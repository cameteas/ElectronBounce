//
//  tutorial.swift
//  Wall Jumper
//
//  Created by Cameron Teasdale on 2017-01-25.
//  Copyright © 2017 Cameron Teasdale. All rights reserved.
//


import Foundation
import SpriteKit
import UIKit
import GameplayKit
import AVFoundation


class tutorial: SKScene, SKPhysicsContactDelegate{
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////contacts////////
    ///////////////////////
    ///////////////////////
    
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
                if stage == 3 {
                    waitForJump()
                    stage += 1
                    stageProgression()
                }
                else {
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
                canHit = false
                self.cheatTime = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector((canHitt)), userInfo: nil, repeats: false)
                
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
                    },
                    SKAction.wait(forDuration: 0.02),
                    SKAction.run {
                        self.spark?.particleBirthRate = 0
                    }
                    ])) 
                }
                
                
            }
            
            
            
        }
        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 8)){
            if stage == 3 || stage == 4 {
                playAgain()
            }
            
            
        }
        
        //        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 4)){
        //            hitEmit(velocity: 1000, from: self.ball.position)
        //        }
    }
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Variables////////
    ///////////////////////
    ///////////////////////
    
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
    
    var title = SKSpriteNode(imageNamed: "electronBounce")
    var titleOnScreen = true
    
    
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
    
    var points = [ CGPoint(x: 100, y: 200),
                   CGPoint(x: 200, y: 600),
                   CGPoint(x: 300, y: 200),
                   CGPoint(x: 400, y: 600),
                   ]
    
    var tapCircle = SKSpriteNode(imageNamed: "tapCircle")
    var tapCircle2 = SKSpriteNode(imageNamed: "tapCircle")

    
    var stage = 1
    var jumpLabelL = SKLabelNode(text: "Arial")
    var jumpLabelR = SKLabelNode(text: "Arial")
    var screenDivider = SKShapeNode(rectOf: CGSize(width: 5, height: 1))
    var stage1JumCount = 0
    var jumpTimer = Timer()
    var canJump = true
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Primary//////////
    //////Functions////////
    ///////////////////////
    
    
    
    override func didMove(to view: SKView) {
        stage1()
        target.run(SKAction.scale(to: 0, duration: 0))

        
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
        initializeBall()
        initializeGround()

        initializeLabel(position:  CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6), fontColor: darkBLueThing, fontSize: 90, text: "", font: "Arial", label: youLose)
        
        
        
        secondText.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6)
        secondText.fontColor = SKColor.black
        secondText.fontSize = 50
        secondText.text = ""
        self.addChild(secondText)
        
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), fontColor: SKColor.black, fontSize: 80, text: "", font: "arial", label: pauseTimer)
        pauseTimer.zPosition = 109
        
        if let x = UserDefaults.standard.object(forKey: "highscore") as? Int{
            highscore = x
            
        }
        
        
        spark?.particleBirthRate = 0
        self.addChild(spark!)
        
        
        title.position = CGPoint(x: self.frame.size.width/2 - 10, y: self.frame.size.height*0.70)
        title.size = CGSize(width: 1000, height: 500)

        
        
        
        /////////Stage 1/////////
        

        
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.25, y: self.frame.size.height*0.6), fontColor: SKColor.white, fontSize: 50, text: "", font: "Arial", label: jumpLabelL)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.75, y: self.frame.size.height*0.6), fontColor: SKColor.white, fontSize: 50, text: "", font: "Arial", label: jumpLabelR)
        screenDivider.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.55)
        screenDivider.fillColor = SKColor.white
        
        
        tapCircle.position = CGPoint(x: self.frame.size.width*0.75, y: self.frame.size.height*0.5)
        tapCircle.size = CGSize(width: 100, height: 100)
        tapCircle.run(SKAction.repeatForever(SKAction.rotate(byAngle: 0.25, duration: 1)))
        

        tapCircle2.position = CGPoint(x: self.frame.size.width*0.25, y: self.frame.size.height*0.5)
        tapCircle2.size = CGSize(width: 100, height: 100)
        tapCircle2.run(SKAction.repeatForever(SKAction.rotate(byAngle: -0.25, duration: 1)))
        
        self.addChild(tapCircle)
        self.addChild(tapCircle2)
        
        testLineDraw()
    }
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfTouch = touch.location(in: self)
            if jumpcount < 2{
                if gameover == false{
                    if canJump == true {
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
                        if stage > 2 {
                            jumpcount += 1
                        }
                        gameStart = false
                        tapsInGame += 1
                    }
                    if tapsInGame == 2 {
                        if stage == 1 {
                            jumpLabelL.run(SKAction.fadeOut(withDuration: 1))
                            jumpLabelR.run(SKAction.fadeOut(withDuration: 1))
                            tapCircle.run(SKAction.fadeOut(withDuration: 1))
                            tapCircle2.run(SKAction.fadeOut(withDuration: 1))
                            screenDivider.run(SKAction.fadeOut(withDuration: 1))
                        }
                    }
                    if tapsInGame == 2 {
                        if stage == 2 {
                            jumpLabelR.run(SKAction.fadeOut(withDuration: 1))
                        }
                    }
                    if tapsInGame == 2 {
                        if stage == 3 {
                            jumpLabelL.run(SKAction.fadeOut(withDuration: 1))
                            jumpLabelR.run(SKAction.fadeOut(withDuration: 1))
                        }
                    }
                    if tapsInGame == 2 {
                        if stage == 4 {
                            jumpLabelL.run(SKAction.fadeOut(withDuration: 1))
                            jumpLabelR.run(SKAction.fadeOut(withDuration: 1))
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
            }
        }
    }
    func tail() {
        // tail settings
        if jumpcount == 2 {
            redVariance = 0
            greenVariance = 95
            blueVariance = 107
        }
        if jumpcount == 1 {
            redVariance = 0
            greenVariance = 140
            blueVariance = 158
        }
        if jumpcount == 0 {
            redVariance = 0
            greenVariance = 223
            blueVariance = 252
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
        
        if (tapsInGame == 4) && (stage == 1) {
            waitForJump()
            stage = 2
            stageProgression()
        }
        if stage == 2 {
            if timesTouched == 2{
                waitForJump()
                stage += 1
                stageProgression()
            }
        }
        if (timesTouched) == 2 {
            if stage == 4 {
                stage += 1
                stageProgression()
            }
        }
        
    }
    
    
    func stageProgression() {
        switch stage {
        case 1:
            stage1()
            break
        case 2:
            stage2()
            break
        case 3:
            stage3()
            break
        case 4:
            stage4()
            break
        case 5:
            stage5()
            break
        default :
            break
        }
    }
    
    func stage1() {
        
        jumpLabelL.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelL.text = "Jump Left"
            },
            SKAction.fadeIn(withDuration: 1)
            
        ]))
        
        jumpLabelR.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelR.text = "Jump Right"
            },
            SKAction.fadeIn(withDuration: 1)
        ]))
        tapCircle2.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.fadeIn(withDuration: 1)
            ]))
        
        tapCircle2.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.fadeIn(withDuration: 1)
            ]))

        
        self.addChild(screenDivider)
        screenDivider.run(SKAction.scaleY(to: 100, duration: 0.5))
        screenDivider.run(SKAction.scaleY(to: 200, duration: 1))
        screenDivider.run(SKAction.scaleY(to: 300, duration: 1.5))
        screenDivider.run(SKAction.scaleY(to: 400, duration: 2))
        
    }
    
    func stage2() {
        playAgain()
        initializeTarget()
        jumpLabelR.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6)
        jumpLabelR.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelR.text = "Hit The Box"
            },
            SKAction.fadeIn(withDuration: 1)
            ]))
        
    }
    
    
    
    func stage3() {
        playAgain()
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        target.physicsBody?.isDynamic = false
        jumpLabelR.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6)
        jumpLabelR.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelR.text = "Hit the Box In Two Jumps"
            },
            SKAction.fadeIn(withDuration: 1)
            ]))
        jumpLabelL.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.55)
        jumpLabelL.fontSize = 30
        jumpLabelL.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelL.text = "(Don't Touch the Bottom)"
            },
            SKAction.fadeIn(withDuration: 1)
            ]))
        
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)



    }
    
    func stage4() {
        playAgain()
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        target.physicsBody?.isDynamic = true
        jumpLabelR.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6)
        jumpLabelR.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelR.text = "Hit the Box Two Times"
            },
            SKAction.fadeIn(withDuration: 1)
            ]))
        jumpLabelL.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.55)
        jumpLabelL.fontSize = 30
        jumpLabelL.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 0),
            SKAction.run {
                self.jumpLabelL.text = "(Jumps are indicated by Trail Color)"
            },
            SKAction.fadeIn(withDuration: 1)
            ]))
        
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

    }
    
    
    func stage5() {
        
        var newGame = wallJumperGame(size: self.size)
        newGame.scaleMode = scaleMode
        tracerStop = true
        self.run(SKAction.sequence([
            SKAction.run {
                self.ball.run(SKAction.scale(to: 0, duration: 1))
                self.target.run(SKAction.scale(to: 0, duration: 1))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.jumpLabelR.run(SKAction.fadeOut(withDuration: 0))
                self.jumpLabelR.text = "You Are Ready"
                self.jumpLabelR.run(SKAction.fadeIn(withDuration: 1))
            },
            SKAction.wait(forDuration: 3),
            SKAction.run {
                self.removeAllChildren()
            },
            SKAction.run {
                
                self.view?.presentScene(newGame)

            }
            ]))
    }
    
    
    
    
    
    
    func waitForJump() {
        SKAction.sequence([
            SKAction.run {
                self.canJump = false
            },
            SKAction.wait(forDuration: 10),
            SKAction.run {
                self.canJump = true
            }
            ])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Secondary////////
    //////Functions////////
    ///////////////////////
    
    
    func playAgain() {
        
        respawnBall()
        resetBallContact()
        respawnTarget()
        resetTargetContact()
        resetGroundContact()
        resetBorderContact()
        
        score = 0
        jumpcount = 0
        timesTouched = 0
        allowPause = false
        jumpPower = 1000
        tapsInGame = 0
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
        
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
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
    
    func resetTargetContact() {
        target.physicsBody?.categoryBitMask = PhysicsCategory.Platform
        target.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border | PhysicsCategory.ground
        target.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
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
        target.glowWidth = 2
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
    
    func testLineDraw() {
        let testLineNode = SKShapeNode(splinePoints: &points, count: points.count)
        testLineNode.strokeColor = SKColor.orange
        testLineNode.lineWidth = 10
        testLineNode.physicsBody? = SKPhysicsBody(edgeChainFrom: testLineNode.path!)
        testLineNode.physicsBody?.affectedByGravity = true
    }
    
    
}
