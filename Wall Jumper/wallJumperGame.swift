//
//  wallJumperGame.swift
//  Wall Jumper
//
//  Created by Cameron Teasdale on 2017-01-20.
//  Copyright © 2017 Cameron Teasdale. All rights reserved.
//

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


class wallJumperGame: SKScene, SKPhysicsContactDelegate{
    
    
    
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
                        self.target.strokeColor = self.darkBLueThing
                        self.target.fillColor = self.darkBLueThing

                    },
                    SKAction.scale(to: 1.2, duration: 0.1),
                    SKAction.scale(to: 0.9, duration: 0.05),
                    SKAction.scale(to: 1.05, duration: 0.03),
                    SKAction.scale(to: 1, duration: 0.02),
                    SKAction.wait(forDuration: 0.15),
                    SKAction.run {
                        self.target.strokeColor = SKColor.white
                        self.target.fillColor = SKColor.white
                    }
                    ]))
                self.ball.run(SKAction.sequence([
                    SKAction.scale(to: 1.2, duration: 0.1),
                    SKAction.scale(to: 0.9, duration: 0.05),
                    SKAction.scale(to: 1.05, duration: 0.03),
                    SKAction.scale(to: 1, duration: 0.02),
                    SKAction.wait(forDuration: 0.15)]))
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
                ball.run(SKAction.sequence([
                    SKAction.run {
                        self.ball.texture = self.HappyText
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.ball.texture = self.NeutralText
                    }
                    
                    ]))
                
                spark?.run(SKAction.sequence([
                    SKAction.run {
                        self.spark?.particlePosition = self.target.position
                        self.spark?.particleBirthRate = 2000
                        self.spark?.yAcceleration = (self.target.physicsBody?.velocity.dy)!
                        self.spark?.xAcceleration = (self.target.physicsBody?.velocity.dx)!
//                        self.spark?.particlePosition.x = (contactBody1.node?.position.x)!
//                        self.spark?.particlePosition.y = (contactBody1.node?.position.y)!

                        

                    },
                    SKAction.wait(forDuration: 0.02),
                    SKAction.run {
                        self.spark?.particleBirthRate = 0
                    }
                    ]))

            }
            
            
            
        }
        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 8)){
            contactBody1.node?.run(SKAction.sequence([
                SKAction.run {
                    self.wait = true
                    self.jumpcount = 3
                    self.canHit = false
                    contactBody1.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 1000)
                    contactBody1.node?.physicsBody?.contactTestBitMask = PhysicsCategory.None
                    contactBody1.node?.physicsBody?.collisionBitMask = PhysicsCategory.None
                    contactBody2.node?.physicsBody?.collisionBitMask = PhysicsCategory.Platform
                    contactBody2.node?.physicsBody?.contactTestBitMask = PhysicsCategory.None
                    self.ball.run(SKAction.sequence([
                        SKAction.scale(to: 1.2, duration: 0.1),
                        SKAction.scale(to: 0.9, duration: 0.05),
                        SKAction.scale(to: 1.05, duration: 0.03),
                        SKAction.scale(to: 1, duration: 0.02),
                        SKAction.wait(forDuration: 0.15)]))
                    self.gameover = true
                },
                SKAction.wait(forDuration: 0.1),
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
            cog.run(SKAction.sequence([
                SKAction.wait(forDuration: 0.2),
                SKAction.scale(to:0.5, duration:0.15),
                SKAction.scale(to:1.2, duration:0.35),
                SKAction.scale(to:0.9, duration:0.05),
                SKAction.scale(to:1.05, duration:0.025),
                SKAction.scale(to:1, duration:0.025),
                SKAction.run {
                    self.actionStart = false
                }
                ]))
            pauseSprite.run(SKAction.scale(to: 0, duration: 0.2))
            self.ball.texture = DeadText
                
        }
        
        //        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 4)){
        //            hitEmit(velocity: 1000, from: self.ball.position)
        //        }
    }
    
    
    
    //declaring variables
    
    var NeutralText = SKTexture(imageNamed: "Neutral2")
    var HappyText = SKTexture(imageNamed: "Happy2")
    var DeadText = SKTexture(imageNamed: "Dead2")
    var focusedText = SKTexture(imageNamed: "focused")
    
    var ball = SKSpriteNode()
    var ballshaddow = SKShapeNode(circleOfRadius: 25)
    var positionOfTouch = CGPoint(x: 0, y: 0)
    var positionOfTouchSave = CGPoint(x: 0, y: 0)
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
    var greenVariance: CGFloat = 0
    var blueVariance: CGFloat = 0
    var cheatTime = Timer()
    var canHit = true
    var pauseSprite = SKSpriteNode(imageNamed: "Pause")
    var highscore = 0
    var secondText = SKLabelNode(fontNamed: "Arial")
    var showtext = true
    var background = SKSpriteNode(imageNamed: "background")
    var greyDarkthing: SKColor = UIColor(red: 52, green: 56, blue: 56, alpha: 1)
    var darkBLueThing: SKColor = UIColor(red: 0, green: 95, blue: 107, alpha: 1)
    let spark = SKEmitterNode (fileNamed: "MyParticle.sks")
    let smoke = SKEmitterNode (fileNamed: "smoke.sks")
    
    var title = SKSpriteNode(imageNamed: "electronBounce")
    var titleOnScreen = true
    
    var cog = SKSpriteNode(imageNamed: "setting")
    
    var pauseTimer = SKLabelNode(fontNamed: "Arial")
    var allowPause = false
    var pauseback = SKShapeNode(rectOf: CGSize(width: 1000, height: 3000))
    var shadowTime = Timer()
    
    var tappedRight = true
    
    var highscorelimiter = 0
    var highscoreConfusion = true
    
    var jumpPower: CGFloat = 1000
    
    var tracerStop = false
    
    var gameStart = true
    
    var actionStart = false
    
    var tapsInGame = 0
    
    var audioPlayer = AVAudioPlayer()
    
    //test change
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
//        UserDefaults.standard.set(0, forKey: "highscore")
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector((tail)), userInfo: nil, repeats: true)
        shadowTime = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector((miscGameLoop)), userInfo: nil, repeats: true)
        
        //initialize gravity and contact
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        //initialize border and background
        self.backgroundColor = SKColor.darkGray
        let scenebody = SKPhysicsBody(edgeLoopFrom: self.frame)
        scenebody.friction = 0
        self.physicsBody = scenebody
        resetBorderContact()
        
        //initialize ball
        
        initializeBall()
        
//        self.addChild(ballshaddow)
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height * 0.96), fontColor: darkBLueThing, fontSize: 40, text: "0", font: "Arial", label: scoreLabel)
        initializeTarget()
        initializeGround()
        initializeLabel(position:  CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6), fontColor: darkBLueThing, fontSize: 90, text: "", font: "Arial", label: youLose)
        
        
        pauseSprite.position = CGPoint(x: self.frame.size.width*0.06, y: self.frame.size.height*0.04)
        pauseSprite.size = CGSize(width: 100, height: 100)
        pauseSprite.run(SKAction.scale(to: 0, duration: 0))
        self.addChild(pauseSprite)
        
        secondText.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6)
        secondText.fontColor = SKColor.black
        secondText.fontSize = 50
        secondText.text = ""
        self.addChild(secondText)
        
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.size = self.frame.size
        background.zPosition = 0
//        self.addChild(background)
        
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), fontColor: SKColor.black, fontSize: 80, text: "", font: "arial", label: pauseTimer)
        pauseTimer.zPosition = 109
        
        if let x = UserDefaults.standard.object(forKey: "highscore") as? Int{
            highscore = x
            
        }
        
        scoreLabel.text = "HighScore: " + "\(highscore)"
        
        spark?.particleBirthRate = 0
        self.addChild(spark!)
        
        smoke?.particleBirthRate = 0
        smoke?.zPosition = 99
        self.addChild(smoke!)
        
        title.position = CGPoint(x: self.frame.size.width/2 - 10, y: self.frame.size.height*0.70)
        title.size = CGSize(width: 1000, height: 500)
        self.addChild(title)
        
        cog.position = CGPoint(x: self.frame.size.width*0.06, y: self.frame.size.height*0.04)
        cog.size = CGSize(width: 90, height: 90)
        self.addChild(cog)
        
        pauseback.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        pauseback.fillColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        pauseback.zPosition = 108
        self.addChild(pauseback)
        
        highscorelimiter = highscore
        
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "hitNoise", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch {
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfTouch = touch.location(in: self)
            if (positionOfTouch.x < self.frame.size.width*0.12) && (positionOfTouch.y < self.frame.size.height*0.08) {
                if jumpcount < 2{
                    if allowPause {
                        if (gamePaused == false) {
                            gamePaused = true
                            pause()
                            pauseback.fillColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.25)
                            self.pauseTimer.text = "Paused"
                            
                        }
                        else if (gamePaused == true) {
                            self.unPause()
                            self.gamePaused = false
                            self.pauseTimer.text = ""
                            self.allowPause = true
                            self.pauseback.fillColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)

//                            allowPause = false
//                            pauseTimer.run(SKAction.sequence([
//                                SKAction.run {
//                                    self.pauseTimer.text = "3"
//                                },
//                                SKAction.wait(forDuration: 1),
//                                SKAction.run {
//                                    self.pauseTimer.text = "2"
//                                },
//                                SKAction.wait(forDuration: 1),
//                                SKAction.run {
//                                    self.pauseTimer.text = "1"
//                                },
//                                SKAction.wait(forDuration: 1),
//                                SKAction.run {
//                                }
//                            ]))
                        }
                    }

                }
            }
            else if gamePaused == false{
                if jumpcount < 2{
                    if gameover == false{
                        allowPause = true
                        
                        ball.physicsBody?.affectedByGravity = true
                        if positionOfTouch.x > self.frame.size.width/2 {
                            self.ball.physicsBody?.velocity.dx = jumpPower
                            self.ball.physicsBody?.velocity.dy = jumpPower
                            tappedRight = false
                        }
                        if positionOfTouch.x < self.frame.size.width/2 {
                            self.ball.physicsBody?.velocity.dx = -jumpPower
                            self.ball.physicsBody?.velocity.dy = jumpPower
                            tappedRight = true
                        }
                        positionOfTouchSave = positionOfTouch
                        jumpcount += 1
                        gameStart = false
                        updateScore()
                        tapsInGame += 1
                        
                        if tapsInGame == 1 {
                            cog.run(SKAction.scale(to: 0, duration: 0.2))
                            pauseSprite.run(SKAction.sequence([
                                SKAction.wait(forDuration: 0.2),
                                SKAction.scale(to:0.5, duration:0.15),
                                SKAction.scale(to:1.2, duration:0.35),
                                SKAction.scale(to:0.9, duration:0.05),
                                SKAction.scale(to:1.05, duration:0.025),
                                SKAction.scale(to:1, duration:0.025)
                            ]))
                        }
                    }
                }
            }
            if wait == false {
                if gameover == true {
                    playAgain()
                    gameover = false
                }
            }
            if titleOnScreen {
                titleOnScreen = false
                title.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: 1)
                ]))
//                cog.run(SKAction.fadeOut(withDuration: 1))
            }
        }
    }
//override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//    for touch: AnyObject in touches {
//        positionOfTouch = touch.location(in: self)
//        if tappedRight{
//            if positionOfTouch.y > positionOfTouchSave.y{
//                ball.physicsBody?.angularVelocity += 10
//            }
//            if positionOfTouch.y < positionOfTouchSave.y {
//                ball.physicsBody?.angularVelocity -= 10
//            }
//        }
//        if tappedRight == false {
//            if positionOfTouch.y > positionOfTouchSave.y{
//                ball.physicsBody?.angularVelocity -= 10
//            }
//            if positionOfTouch.y < positionOfTouchSave.y {
//                ball.physicsBody?.angularVelocity += 10
//            }
//        }
//    }
//}
//    
    func tail() {
        // tail settings
        if jumpcount == 2 {
            redVariance = 0
            greenVariance = 95
            blueVariance = 107
            smoke?.particleBirthRate = 0
        }
        if jumpcount == 1 {
            redVariance = 0
            greenVariance = 140
            blueVariance = 158
            smoke?.particleBirthRate = 0
        }
        if jumpcount == 0 {
            redVariance = 0
            greenVariance = 223
            blueVariance = 252
            smoke?.particlePosition = ball.position
            smoke?.particleBirthRate = 0
//            smoke?.xAcceleration = -(ball.physicsBody?.velocity.dx)!
//            smoke?.yAcceleration = -(ball.physicsBody?.velocity.dy)!
        }
        var marquer = SKShapeNode(circleOfRadius: 25)
        marquer.position = self.ball.position
        if gameover{
            marquer.strokeColor = UIColor(red: (0 + redVariance)/255, green: (0 + greenVariance)/255, blue: (0 + blueVariance)/255, alpha: 1)
        }
        else {
            marquer.strokeColor = UIColor(red: redVariance/255, green: greenVariance/255, blue:  blueVariance/255, alpha: 1)
        }
        
        marquer.lineWidth = 25
        marquer.zPosition = 10
        if tracerStop == false {
            self.addChild(marquer)
        }
        
        
        marquer.run(SKAction.scale(by: 0.01, duration: 2))
        marquer.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeOut(withDuration: 1),
            SKAction.removeFromParent()
            ]))
        
    }
    
    func miscGameLoop() {
        
        var outOfBoundsCheck = 0
        if self.target.position.x > self.frame.size.width {
            outOfBoundsCheck += 1
        }
        if self.target.position.x < 0 {
            outOfBoundsCheck += 1
        }
        if self.target.position.y > self.frame.size.height {
            outOfBoundsCheck += 1
        }
        if self.target.position.y < 0 {
            outOfBoundsCheck += 1
        }
        if outOfBoundsCheck > 0 {
            self.target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        }
        
        if highscore > highscorelimiter{
//            if highscoreConfusion {
//               jumpPower = 850
//                highscoreConfusion = false
//            }
//            else if highscoreConfusion == false {
//                jumpPower = 1150
//                highscoreConfusion = true
//            }
            jumpPower = 850
            
            
        }
        if tapsInGame == 0{
            if ball.physicsBody?.velocity == CGVector(dx: 0, dy: 1000) {
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
        }

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
        allowPause = false
        jumpPower = 1000
        highscorelimiter = highscore
        tapsInGame = 0
        canHit = true
        }

    
    func respawnTarget() {
        target.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0.2),
            SKAction.rotate(toAngle: 0, duration: 0),
            SKAction.move(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), duration: 0),
            SKAction.scale(to:0.5, duration:0.15),
            SKAction.scale(to:1.2, duration:0.35),
            SKAction.scale(to:0.9, duration:0.05),
            SKAction.scale(to:1.05, duration:0.025),
            SKAction.scale(to:1, duration:0.025)
            ]))
        
//        target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func resetTargetContact() {
        target.physicsBody?.categoryBitMask = PhysicsCategory.Platform
        target.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border | PhysicsCategory.ground
        target.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
    }
    
    func respawnBall() {
        
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.angularVelocity = 0
        ball.texture = NeutralText
        ball.run(SKAction.sequence([
            SKAction.run {
                self.tracerStop = true
            },
            SKAction.scale(to: 0, duration: 0.2),
            SKAction.run {
                self.ball.position = CGPoint(x: (self.frame.size.width/2) + 2, y: (self.frame.size.height*0.25) + 2)
            },
            SKAction.rotate(toAngle: 0, duration: 0),
            SKAction.scale(to:0.5, duration:0.15),
            SKAction.scale(to:1.2, duration:0.35),
            SKAction.run {
                self.tracerStop = false
            },
            SKAction.scale(to:0.9, duration:0.05),
            SKAction.scale(to:1.05, duration:0.025),
            SKAction.scale(to:1, duration:0.025)
            ]))
        
        gameStart = true
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
        var shape = SKSpriteNode(imageNamed: "spark2")
        shape.size = CGSize(width: 25, height: 5)
//        shape.strokeColor = SKColor.orange
//        shape.lineWidth = 5
        shape.position = position
        
        shape.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        shape.physicsBody?.velocity = Velocity
        shape.physicsBody?.mass = 1
        shape.physicsBody?.restitution = 0.5
        shape.physicsBody?.linearDamping = 0
        shape.physicsBody?.mass = 0.01
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
        label.zPosition = 100
        self.addChild(label)
    }
    
    func initializeBall() {
        ball.texture = NeutralText
        ball.size = CGSize(width: 81, height: 81)
        ball.position = CGPoint(x: (self.frame.size.width/2) + 2, y: (self.frame.size.height*0.25) + 2)
        ball.physicsBody?.angularDamping = 1
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.mass = 10
        ball.physicsBody?.affectedByGravity = false
        ball.zPosition = 100
        resetBallContact()
        self.addChild(ball)
    }
    
    func initializeTarget() {
        target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        target.lineWidth = 5
        target.strokeColor = SKColor.white
        target.fillColor = SKColor.white
        target.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        target.physicsBody?.affectedByGravity = false
        target.physicsBody?.angularDamping = 20
        target.physicsBody?.restitution = 0.5
        target.zPosition = 40
        resetTargetContact()
        self.addChild(target)
    }
    
    func initializeGround() {
        ground.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.04)
        ground.fillColor = darkBLueThing
        ground.strokeColor = darkBLueThing
        ground.lineWidth = 15
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        resetGroundContact()
        self.addChild(ground)
    }
    
    var ballVelocitySave = CGVector(dx: 0, dy: 0)
    var squareVelocitySave = CGVector(dx: 0, dy: 0)
    var gamePaused = false
    var canAccessPause = false
    
    func pause() {
        self.isPaused = true
//        ballVelocitySave = (self.ball.physicsBody?.velocity)!
//        squareVelocitySave = (self.target.physicsBody?.velocity)!
//        self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//        self.ball.physicsBody?.affectedByGravity = false
//        self.target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//        self.target.physicsBody?.affectedByGravity = false
    }
    func unPause() {
        self.isPaused = false
//        self.ball.physicsBody?.velocity = ballVelocitySave
//        self.ball.physicsBody?.affectedByGravity = true
//        self.target.physicsBody?.velocity = squareVelocitySave
//        self.target.physicsBody?.affectedByGravity = false
    }

}
