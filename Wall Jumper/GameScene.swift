//
//  GameScene.swift
//  Wall Jumper
//
//  Created by Cameron Teasdale on 2017-01-20.
//  Copyright © 2017 Cameron Teasdale. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameplayKit
import AVFoundation


class GameScene: SKScene, SKPhysicsContactDelegate{
    
    
    
    struct PhysicsCategory {
        
        static let None :UInt32 = 0         //0
        static let Ball :UInt32 = 0b10       //2
        static let Platform :UInt32 = 0b1  //1
        static let Border :UInt32 = 0b100   //4
        static let ground :UInt32 = 0b1000 //8
        static let All :UInt32 = UInt32.max
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var contactBody1 :SKPhysicsBody
        var contactBody2 :SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            contactBody1 = contact.bodyA
            contactBody2 = contact.bodyB
        }
        else{
            contactBody1 = contact.bodyB
            contactBody2 = contact.bodyA
        }
        
        if ((contactBody1.categoryBitMask == 1 ) && (contactBody2.categoryBitMask == 2)){
            if self.canHit {
                
                self.target.run(SKAction.sequence([
                    SKAction.run {
                        self.target.strokeColor = SKColor.orange
                    },
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        self.target.strokeColor = SKColor.black
                    }
                    ]))
                self.jumpcount = 0
                timesTouched += 1
                updateScore()
                canHit = false
                self.cheatTime = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector((canHitt)), userInfo: nil, repeats: false)
                if timesTouched > highscore {
                    highscore = timesTouched
                    UserDefaults.standard.set(highscore, forKey: "highscore")
                }
                scoreLabel.text = "HighScore: " + "\(highscore)"
            }
            
            
            
        }
        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 8)){
            contactBody1.node?.run(SKAction.sequence([
                SKAction.run {
                    self.wait = true
                    self.jumpcount = 3
                    contactBody1.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 1000)
                    contactBody1.node?.physicsBody?.contactTestBitMask = PhysicsCategory.None
                    contactBody1.node?.physicsBody?.collisionBitMask = PhysicsCategory.None
                    contactBody2.node?.physicsBody?.collisionBitMask = PhysicsCategory.Platform
                    contactBody2.node?.physicsBody?.contactTestBitMask = PhysicsCategory.None
                    self.gameover = true
                },
                SKAction.wait(forDuration: 1),
                SKAction.run {
                    if self.gameover == true {
                        self.youLose.text = "\(self.timesTouched)" + " Touches!"
                    }
                },
                SKAction.wait(forDuration: 0.5),
                SKAction.run {
                    self.wait = false
                }
                ]))
        }
        
        //        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 4)){
        //            hitEmit(velocity: 1000, from: self.ball.position)
        //        }
    }
    
    
    
    //declaring variables
    var ball = SKShapeNode(circleOfRadius: 25)
    var positionOfTouch = CGPoint(x: 0, y: 0)
    var scoreLabel = SKLabelNode(fontNamed: "Arial")
    var score = 0
    var timer = Timer()
    var jumpcount = 0
    var target = SKShapeNode(rectOf: CGSize(width: 25, height: 25))
    var ground = SKShapeNode(rectOf: CGSize(width: 800, height: 100))
    var youLose = SKLabelNode(fontNamed: "Arial")
    var timesTouched = 0
    var gameover = false
    var wait = false
    var redVariance: CGFloat = 0
    var geenVariance: CGFloat = 0
    var blueVariance: CGFloat = 0
    var cheatTime = Timer()
    var canHit = true
    var helpSprite = SKSpriteNode(imageNamed: "help")
    var highscore = 0
    var secondText = SKLabelNode(fontNamed: "Arial")
    var showtext = true
    
    var helpline1 = SKLabelNode(fontNamed: "Arial")
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        var newGame = wallJumperGame(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector((tail)), userInfo: nil, repeats: true)
        
        
        //initialize gravity and contact
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        //initialize border and background
        self.backgroundColor = UIColor.white
        let scenebody = SKPhysicsBody(edgeLoopFrom: self.frame)
        scenebody.friction = 0
        self.physicsBody = scenebody
        resetBorderContact()
        
        //initialize ball
        
        
        initializeBall()
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height * 0.96), fontColor: SKColor.black, fontSize: 40, text: "0", font: "Arial", label: scoreLabel)
        
        
        //initialize score label
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height * 0.96)
        //scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
        
        //initialize target
        target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        target.lineWidth = 5
        target.strokeColor = SKColor.black
        target.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        target.physicsBody?.affectedByGravity = false
        resetTargetContact()
        self.addChild(target)
        
        //initialize ground
        ground.position = CGPoint(x: self.frame.size.width, y: 0)
        ground.strokeColor = SKColor.black
        ground.lineWidth = 15
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        resetGroundContact()
        self.addChild(ground)
        
        //initialize text at end
        youLose.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.75)
        youLose.fontSize = 90
        youLose.fontColor = SKColor.black
        youLose.text = ""
        self.addChild(self.youLose)
        
        helpSprite.position = CGPoint(x: self.frame.size.width*0.03, y: self.frame.size.height*0.03)
        helpSprite.scale(to: CGSize(width:0.9, height: 0.9))
        self.addChild(helpSprite)
        
        secondText.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6)
        secondText.fontColor = SKColor.black
        secondText.fontSize = 50
        secondText.text = ""
        self.addChild(secondText)
        
        
        if let x = UserDefaults.standard.object(forKey: "highscore") as? Int{
            highscore = x
            
        }
        
        scoreLabel.text = "HighScore: " + "\(highscore)"
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfTouch = touch.location(in: self)
            if jumpcount < 2{
                if gameover == false{
                    ball.physicsBody?.affectedByGravity = true
                    if positionOfTouch.x > self.frame.size.width/2 {
                        self.ball.physicsBody?.velocity.dx = 1000
                        self.ball.physicsBody?.velocity.dy = 1000
                    }
                    if positionOfTouch.x < self.frame.size.width/2 {
                        self.ball.physicsBody?.velocity.dx = -1000
                        self.ball.physicsBody?.velocity.dy = 1000
                    }
                    jumpcount += 1
                    updateScore()
                }
            }
            if wait == false {
                if gameover == true {
                    playAgain()
                    gameover = false
                }
            }
        }
    }
    
    
    func tail() {
        // tail settings
        if jumpcount == 0 {
            redVariance = 150
        }
        if jumpcount == 1 {
            redVariance = 75
        }
        if jumpcount == 2 {
            redVariance = 0
        }
        var marquer = SKShapeNode(circleOfRadius: 25)
        marquer.position = self.ball.position
        if gameover{
            marquer.strokeColor = UIColor(red: 76/255, green: 0.3, blue: 100/255, alpha: 1)
        }
        else {
            marquer.strokeColor = UIColor(red: (76 + redVariance)/255, green: 0.3, blue: 100/255, alpha: 1)
        }
        
        marquer.lineWidth = 25
        marquer.zPosition = 10
        self.addChild(marquer)
        
        marquer.run(SKAction.scale(by: 0.01, duration: 2))
        marquer.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeOut(withDuration: 1),
            SKAction.removeFromParent()
            ]))
        
    }
    
    
    func updateScore() {
        score = 2 - jumpcount
        youLose.text = "\(timesTouched)"
    }
    
    func playAgain() {
        
        respawnBall()
        resetBallContact()
        respawnTarget()
        resetTargetContact()
        resetGroundContact()
        resetBorderContact()
        if gameover == true {
            if timesTouched == 1 {
                youLose.text = "\(timesTouched)" + " Touch!"
            }
            else {
                youLose.text = "\(timesTouched)" + " Touches!"
            }
            secondText.text = ""
            
        }
        else{
            youLose.text = "\(timesTouched)"
        }
        
        score = 0
        jumpcount = 0
        timesTouched = 0
        updateScore()
    }
    
    func respawnTarget() {
        target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func resetTargetContact() {
        target.physicsBody?.categoryBitMask = PhysicsCategory.Platform
        target.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border | PhysicsCategory.ground
        target.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
    }
    
    func respawnBall() {
        ball.position = CGPoint(x: (self.frame.size.width/2) + 2, y: (self.frame.size.height*0.25) + 2)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func resetBallContact() {
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Border | PhysicsCategory.Platform | PhysicsCategory.ground
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Platform
    }
    
    func resetGroundContact() {
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.Platform | PhysicsCategory.Ball
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
    }
    
    func resetBorderContact() {
        self.physicsBody?.categoryBitMask = PhysicsCategory.Border
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None
    }
    func canHitt()
    {
        canHit = true
    }
    
    func createEmitNode(position: CGPoint, Velocity: CGVector){
        var shape = SKShapeNode(circleOfRadius: 10)
        shape.strokeColor = SKColor.orange
        shape.lineWidth = 5
        shape.position = position
        
        shape.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        shape.physicsBody?.velocity = Velocity
        shape.physicsBody?.mass = 1
        shape.physicsBody?.restitution = 0.5
        shape.physicsBody?.linearDamping = 0
        self.addChild(shape)
        
        shape.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
            ]))
    }
    func hitEmit(velocity: CGFloat, from: CGPoint) {
        createEmitNode(position: from, Velocity: CGVector(dx: velocity, dy: 0))
        createEmitNode(position: from, Velocity: CGVector(dx: velocity, dy: -velocity))
        createEmitNode(position: from, Velocity: CGVector(dx: 0, dy: 0))
        createEmitNode(position: from, Velocity: CGVector(dx: -velocity, dy: -velocity))
        createEmitNode(position: from, Velocity: CGVector(dx: -velocity, dy: 0))
        createEmitNode(position: from, Velocity: CGVector(dx: -velocity, dy: velocity))
        createEmitNode(position: from, Velocity: CGVector(dx: 0, dy: 100))
        createEmitNode(position: from, Velocity: CGVector(dx: velocity, dy: velocity))
    }
    
    func showInstruction(label: SKLabelNode, label2: SKLabelNode, line: SKShapeNode) {
        
        var intructions = SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                label.text = "tap to                tap to"
                label2.text = "jump left            jump right"
            },
            SKAction.fadeIn(withDuration: 1)
            ])
        label.run(intructions)
        label2.run(intructions)
        
        line.run(SKAction.fadeIn(withDuration: 1))
    }
    
    func removeInstructions(label: SKLabelNode, label2: SKLabelNode, line: SKShapeNode) {
        label.run(SKAction.fadeOut(withDuration: 1))
        label2.run(SKAction.fadeOut(withDuration: 1))
        
        line.run(SKAction.fadeOut(withDuration: 1))
    }
    
    func initializeLabel(position: CGPoint, fontColor: SKColor, fontSize: CGFloat, text: String, font: String, label: SKLabelNode) {
        label.position = position
        label.fontColor = fontColor
        label.fontSize = fontSize
        label.text = text
        label.fontName = font
    }
    
    func initializeBall() {
        ball.strokeColor = SKColor.black
        ball.lineWidth = 10
        ball.fillColor = SKColor.white
        ball.position = CGPoint(x: (self.frame.size.width/2) + 2, y: (self.frame.size.height*0.25) + 2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.mass = 10
        ball.physicsBody?.affectedByGravity = false
        ball.zPosition = 100
        resetBallContact()
        self.addChild(ball)
    }
    
    
    
    
    
    
}
