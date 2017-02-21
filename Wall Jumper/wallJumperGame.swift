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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////contacts////////
    ///////////////////////
    ///////////////////////

    struct PhysicsCategory {
        
        static let None :UInt32 = 0         //0
        static let Ball :UInt32 = 0b10      //2
        static let Platform :UInt32 = 0b1   //1
        static let Border :UInt32 = 0b100   //4
        static let ground :UInt32 = 0b1000  //8
        static let coin :UInt32 = 0b10000   //16

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
                        self.target.strokeColor = self.colorSwitch
                        self.target.fillColor = self.colorSwitch

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
                switch gameModes {
                case 1:
                    if timesTouched > beginnerHighscore {
                        beginnerHighscore = timesTouched
                        UserDefaults.standard.set(beginnerHighscore, forKey: "BeginnerHighscore")
                    }
                    scoreLabel.text = "Beginner HighScore: " + "\(beginnerHighscore)"
                    break
                case 2:
                    if timesTouched > classicHighscore {
                        classicHighscore = timesTouched
                        UserDefaults.standard.set(classicHighscore, forKey: "ClassicHighscore")
                    }
                    scoreLabel.text = "Classic HighScore: " + "\(classicHighscore)"
                    break
                case 3:
                    if timesTouched > hardcoreHighscore {
                        hardcoreHighscore = timesTouched
                        UserDefaults.standard.set(hardcoreHighscore, forKey: "HardcoreHighscore")
                    }
                    scoreLabel.text = "HardCore HighScore: " + "\(hardcoreHighscore)"
                    break
                default:
                    break
                }
                
                
                ball.run(SKAction.sequence([
                    SKAction.run {
                        self.ball.texture = self.ballTexture[1]
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        if self.gameover != true {
                          self.ball.texture = self.ballTexture[0]
                        }
                    }
                    
                    ]))
                
                spark?.run(SKAction.sequence([
                    SKAction.run {
                        self.spark?.particlePosition = self.target.position
                        self.spark?.particleBirthRate = 1000
                        self.spark?.yAcceleration = (self.target.physicsBody?.velocity.dy)! + (self.ball.physicsBody?.velocity.dy)!
                        self.spark?.xAcceleration = (self.target.physicsBody?.velocity.dx)! + (self.ball.physicsBody?.velocity.dx)!
//                        self.spark?.particlePosition.x = (contactBody1.node?.position.x)!
//                        self.spark?.particlePosition.y = (contactBody1.node?.position.y)!

                        

                    },
                    SKAction.wait(forDuration: 0.02),
                    SKAction.run {
                        self.spark?.particleBirthRate = 0
                    }
                    ]))
                self.coinCounter += 1
                self.coinLabel.text = "\(coinCounter)"
                UserDefaults.standard.set(coinCounter, forKey: "coins")


            }
            
            
            
        }
        if ((contactBody1.categoryBitMask == 2) && (contactBody2.categoryBitMask == 8)){
            contactBody1.node?.run(SKAction.sequence([
                SKAction.run {
                    self.wait = true
                    self.jumpcount = 3
                    self.canHit = false
                    self.tapsInGame = 0
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
                        self.showGameover()
                    }
                },
                SKAction.wait(forDuration: 0.5),
                SKAction.run {
                    self.wait = false
                }
                ]))

            pauseSprite.run(SKAction.scale(to: 0, duration: 0.2))
            self.ball.texture = self.ballTexture[2]
            self.cog.run(SKAction.sequence([
                SKAction.wait(forDuration: 0.2),
                SKAction.scale(to:0.8, duration:0.1),
                SKAction.scale(to:1.2, duration:0.1),
                SKAction.scale(to:1, duration:0.1),
                SKAction.run {
                    self.actionStart = false
                }
                ]))
        }
        
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Variables////////
    ///////////////////////
    ///////////////////////

    
    
    var blueTextures:Array<SKTexture> = []
    var yellowTextures:Array<SKTexture> = []
    var violetTextures:Array<SKTexture> = []
    var redTextures:Array<SKTexture> = []
    var greenTextures:Array<SKTexture> = []
    var fuschiaTextures:Array<SKTexture> = []
    var orangeTextures:Array<SKTexture> = []
    
    
    var ballTexture:Array<SKTexture> = []

    
    
    
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
    var cheatTime = Timer()
    var canHit = true
    var pauseSprite = SKSpriteNode(imageNamed: "Pause")
    var beginnerHighscore = 0
    var classicHighscore = 0
    var hardcoreHighscore = 0
    var secondText = SKLabelNode(fontNamed: "Arial")
    var showtext = true
    var background = SKSpriteNode(imageNamed: "background")
    var greyDarkthing: SKColor = UIColor(red: 52, green: 56, blue: 56, alpha: 1)
    var darkBLueThing: SKColor = UIColor(red: 0, green: 95, blue: 107, alpha: 1)
    let spark = SKEmitterNode (fileNamed: "MyParticle.sks")
    
    var title = SKSpriteNode(imageNamed: "electronBounce")
    var titleOnScreen = true
    
    var cog = SKSpriteNode(imageNamed: "setting")
    
    
    var gameModes = 2
    var classicButton = SKSpriteNode(imageNamed: "classicMode")
    var classicLabel = SKLabelNode(fontNamed: "Helvetica")
    var customizeButton = SKSpriteNode(imageNamed: "customize")
    var customizeLabel = SKLabelNode(fontNamed: "Helvetica")
    var tutorialButton = SKSpriteNode(imageNamed: "tutorialButton")
    var statisticsLabel = SKLabelNode(fontNamed: "Helvetica")
    var playGameButton = SKSpriteNode(imageNamed: "PlayButton")
    var playLabel = SKLabelNode(fontNamed: "Helvetica")
    
    
    var pauseTimer = SKLabelNode(fontNamed: "Arial")
    var pauseTimer2 = SKLabelNode(fontNamed: "Arial")
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
    
    var settingsIsShown = false

    var jumpcountRestriction = 2
    
    var tailColor = 0
    
    var theme = 0
    
    var tailType = 0
    
    var particle = 0
    var blueSpray = SKTexture(imageNamed: "BlueParticle")
    var yellowSpray = SKTexture(imageNamed: "YellowParticle")
    var violetSpray = SKTexture(imageNamed: "PurpleParticle")
    var redSpray = SKTexture(imageNamed: "RedParticle")
    var greenSpray = SKTexture(imageNamed: "GreenParticle")
    var fuschiaSpray = SKTexture(imageNamed: "FuschiaParticle")
    var orangeSpray = SKTexture(imageNamed: "OrangeParticle")
    
    
    
    var costume = 1
    var hatSelection = 0
    
    var tophatPic = SKSpriteNode(imageNamed: "tophat")
    var fruithatPic = SKSpriteNode(imageNamed: "fruit hat")
    var wartpic = SKSpriteNode(imageNamed: "Wart")
    var vikingPic = SKSpriteNode(imageNamed: "viking")
    var spacePic = SKSpriteNode(imageNamed: "spaceSuit")
    var poshPic = SKSpriteNode(imageNamed: "posh")
    var fishPic = SKSpriteNode(imageNamed: "fishbowl")
    var haloPic = SKSpriteNode(imageNamed: "halo")
    var strawPic = SKSpriteNode(imageNamed: "strawhat")
    var tiePic = SKSpriteNode(imageNamed: "tie")
    var plasterPic = SKSpriteNode(imageNamed: "plaster mask")
    
    
    
    var grayDark = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
    var grayMid = UIColor(red: 33/255, green: 33/255, blue: 34/255, alpha: 1)
    var grayMidLight = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    var grayLight = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
    
    
    let blueBright = UIColor(red: 0, green: 223/255, blue: 252/255, alpha: 1)
    let blueMid = UIColor(red: 0, green: 140/255, blue: 158/255, alpha: 1)
    let blueDark = UIColor(red: 0, green: 50/255, blue: 60/255, alpha: 1)
    
    let yellowBright = UIColor(red: 234/255, green: 220/255, blue: 0/255, alpha: 1)
    let yellowMid = UIColor(red: 161/255, green: 151/255, blue: 0/255, alpha: 1)
    let yellowDark = UIColor(red: 102/255, green: 96/255, blue: 0/255, alpha: 1)
    
    let violetBright = UIColor(red: 167/255, green: 109/255, blue: 251/255, alpha: 1)
    let violetMid = UIColor(red: 111/255, green: 73/255, blue: 167/255, alpha: 1)
    let violetDark = UIColor(red: 70/255, green: 46/255, blue: 106/255, alpha: 1)
    
    let violetBright1 = UIColor(red: 165/255, green: 107/255, blue: 249/255, alpha: 1)
    let violetMid1 = UIColor(red: 111/255, green: 73/255, blue: 167/255, alpha: 1)
    let violetDark1 = UIColor(red: 70/255, green: 46/255, blue: 106/255, alpha: 1)
    
    let violetBright2 = UIColor(red: 169/255, green: 111/255, blue: 253/255, alpha: 1)
    let violetMid2 = UIColor(red: 111/255, green: 73/255, blue: 167/255, alpha: 1)
    let violetDark2 = UIColor(red: 70/255, green: 46/255, blue: 106/255, alpha: 1)
    
    let redBright = UIColor(red: 224/255, green: 0/255, blue: 40/255, alpha: 1)
    let redMid = UIColor(red: 127/255, green: 0/255, blue: 22/255, alpha: 1)
    let redDark = UIColor(red: 58/255, green: 0/255, blue: 10/255, alpha: 1)
    
    
    let greenBright = UIColor(red: 0/255, green: 234/255, blue: 27/255, alpha: 1)
    let greenMid = UIColor(red: 0/255, green: 131/255, blue: 15/255, alpha: 1)
    let greenDark = UIColor(red: 0/255, green: 66/255, blue: 8/255, alpha: 1)
    
    let fuschiaBright = UIColor(red: 251/255, green: 109/255, blue: 233/255, alpha: 1)
    let fuschiaMid = UIColor(red: 157/255, green: 68/255, blue: 146/255, alpha: 1)
    let fuschiaDark = UIColor(red: 88/255, green: 38/255, blue: 82/255, alpha: 1)
    
    let orangeBright = UIColor(red: 234/255, green: 128/255, blue: 0/255, alpha: 1)
    let orangeMid = UIColor(red: 164/255, green: 90/255, blue: 0/255, alpha: 1)
    let orangeDark = UIColor(red: 112/255, green: 61/255, blue: 0/255, alpha: 1)
    
    var colorSwitch = SKColor.white
    var accentSwitch = SKColor.white
    
    
    var coinCounter = 0
    var coinColor = UIColor(red: 211/255, green: 144/255, blue: 48/255, alpha: 1)
    var coinLabel = SKLabelNode(fontNamed: "Arial")
    var coinIcon = SKSpriteNode(imageNamed: "Coin")
    
    var gameCoin = SKSpriteNode(imageNamed: "Coin")
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Primary//////////
    //////Functions////////
    ///////////////////////

    
    
    override func didMove(to view: SKView) {
        
        if let x = UserDefaults.standard.object(forKey: "selectedPosition2") as? Int{
            tailColor = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition1") as? Int{
            theme = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition3") as? Int{
            tailType = x
        }
        if let x = UserDefaults.standard.object(forKey: "coins") as? Int{
            coinCounter = x
        }
        
        
        let colorBrightArray = [blueBright, yellowBright, violetBright, redBright, greenBright, fuschiaBright, orangeBright]
        createTextureSets()

        switch theme{
        case 8:
            ballTexture = blueTextures
            
            colorSwitch = colorBrightArray[0]
            break
        case 9:
            ballTexture = yellowTextures
            
            colorSwitch = colorBrightArray[1]
            break
        case 10:
            ballTexture = violetTextures
            
            colorSwitch = colorBrightArray[2]
            break
        case 11:
            ballTexture = redTextures
            
            colorSwitch = colorBrightArray[3]
            break
        case 4:
            ballTexture = greenTextures
            
            colorSwitch = colorBrightArray[4]
            break
        case 5:
            ballTexture = fuschiaTextures
            
            colorSwitch = colorBrightArray[5]
            break
        case 6:
            ballTexture = orangeTextures
            
            colorSwitch = colorBrightArray[6]
            break
        default:
            ballTexture = blueTextures
            
            colorSwitch = colorBrightArray[0]
            break
        }
        switch tailColor{
        case 8:
            accentSwitch = colorBrightArray[0]
            spark?.particleTexture = blueSpray
            break
        case 9:
            accentSwitch = colorBrightArray[1]
            spark?.particleTexture = yellowSpray
            break
        case 10:
            accentSwitch = colorBrightArray[2]
            spark?.particleTexture = violetSpray
            break
        case 11:
            accentSwitch = colorBrightArray[3]
            spark?.particleTexture = redSpray
            break
        case 4:
            accentSwitch = colorBrightArray[4]
            spark?.particleTexture = greenSpray
            break
        case 5:
            accentSwitch = colorBrightArray[5]
            spark?.particleTexture = fuschiaSpray
            break
        case 6:
            accentSwitch = colorBrightArray[6]
            spark?.particleTexture = orangeSpray
            break
        default:
            accentSwitch = colorBrightArray[0]
            spark?.particleTexture = blueSpray
            break
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector((tail)), userInfo: nil, repeats: true)
        shadowTime = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector((miscGameLoop)), userInfo: nil, repeats: true)
        
        //initialize gravity and contact
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        //initialize border and background
        self.backgroundColor = grayMid
        let scenebody = SKPhysicsBody(edgeLoopFrom: self.frame)
        scenebody.friction = 0
        self.physicsBody = scenebody
        resetBorderContact()
        
        //initialize ball
        changeCostume()
        initializeBall()
        
//        self.addChild(ballshaddow)
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height * 0.96), fontColor: accentSwitch, fontSize: 40, text: "0", font: "Helvetica", label: scoreLabel, node: self)
        initializeTarget()
        initializeGround()
        initializeLabel(position:  CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6), fontColor: colorSwitch, fontSize: 130, text: "", font: "Helvetica", label: youLose, node: self)
        initializeLabel(position:  CGPoint(x: self.frame.size.width*0.9, y: self.frame.size.height*0.9), fontColor: coinColor, fontSize: 40, text: "\(coinCounter)", font: "Helvetica", label: coinLabel, node: self)
        
        coinIcon.position = CGPoint(x: self.frame.size.width*0.9, y: self.frame.size.height*0.96)
        coinIcon.size = CGSize(width: 81, height: 81)
        self.addChild(coinIcon)
        
        pauseSprite.position = CGPoint(x: self.frame.size.width*0.08, y: self.frame.size.height*0.95)
        pauseSprite.size = CGSize(width: 90, height: 90)
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
        
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.85), fontColor: colorSwitch, fontSize: 80, text: "", font: "arial", label: pauseTimer, node: self)
        pauseTimer.zPosition = 109
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.8), fontColor: colorSwitch, fontSize: 40, text: "", font: "arial", label: pauseTimer2, node: self)
        pauseTimer2.zPosition = 109
        
        if let x = UserDefaults.standard.object(forKey: "BeginnerHighscore") as? Int{
            beginnerHighscore = x
        }
        if let x = UserDefaults.standard.object(forKey: "ClassicHighscore") as? Int{
            classicHighscore = x
        }
        if let x = UserDefaults.standard.object(forKey: "HardcoreHighscore") as? Int{
            hardcoreHighscore = x
        }
        
        switch gameModes {
        case 1:
            scoreLabel.text = "Beginner HighScore: " + "\(beginnerHighscore)"
            break
        case 2:
            scoreLabel.text = "Classic HighScore: " + "\(classicHighscore)"
            scoreLabel.run(SKAction.sequence([
                SKAction.scale(to: 0, duration: 0),
                SKAction.wait(forDuration: 0.4),
                SKAction.scale(to: 0.8, duration: 0.1),
                SKAction.scale(to: 1.2, duration: 0.1),
                SKAction.scale(to: 1, duration: 0.1)
                ]))
            break
        case 3:
            scoreLabel.text = "Hardcore HighScore: " + "\(hardcoreHighscore)"
            break
        default:
            break
        }
        
        spark?.particleBirthRate = 0
        self.addChild(spark!)
        
        
        title.position = CGPoint(x: self.frame.size.width/2 - 10, y: self.frame.size.height*0.70)
        title.size = CGSize(width: 1000, height: 500)
        self.addChild(title)
        
        cog.position = CGPoint(x: self.frame.size.width*0.08, y: self.frame.size.height*0.96)
        cog.size = CGSize(width: 90, height: 90)
        self.cog.zPosition = 110
        cog.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.4),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))

        self.addChild(cog)
        
        classicButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        classicButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.7)
        classicButton.zPosition = 110
        classicButton.size = CGSize(width: 455, height: 135)
        //classicButton.alpha = 0
        classicButton.run(SKAction.scale(to: 0, duration: 0))
        
        initializeLabel(position: CGPoint(x:0,y:0-20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: classicLabel, node: classicButton)
        classicLabel.zPosition = 111
        
        customizeButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        customizeButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.55)
        customizeButton.zPosition = 110
        customizeButton.size = CGSize(width: 455, height: 135)
        //customizeButton.alpha = 0
        customizeButton.run(SKAction.scale(to: 0, duration: 0))
        
        initializeLabel(position: CGPoint(x:0,y:0-20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: customizeLabel, node: customizeButton)
        customizeLabel.zPosition = 111
        
        tutorialButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        tutorialButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.4)
        tutorialButton.zPosition = 110
        tutorialButton.size = CGSize(width: 455, height: 135)
        //tutorialButton.alpha = 0
        tutorialButton.run(SKAction.scale(to: 0, duration: 0))
        
        initializeLabel(position: CGPoint(x:0,y:0-20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: statisticsLabel, node: tutorialButton)
        statisticsLabel.zPosition = 111
        
        playGameButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        playGameButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.25)
        playGameButton.zPosition = 110
        playGameButton.size = CGSize(width: 455, height: 135)
        //playGameButton.alpha = 0
        playGameButton.run(SKAction.scale(to: 0, duration: 0))
        
        initializeLabel(position: CGPoint(x:0,y:0-20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: playLabel,  node: playGameButton)
        playLabel.zPosition = 111
        
        pauseback.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        pauseback.fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        pauseback.zPosition = 108
        self.addChild(pauseback)
        
        title.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.5),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
        
        self.addChild(classicButton)
        self.addChild(tutorialButton)
        self.addChild(customizeButton)
        self.addChild(playGameButton)
        
        
        
        switch gameModes {
        case 1:
            highscorelimiter = beginnerHighscore
            break
        case 2:
            highscorelimiter = classicHighscore
            break
        case 3:
            highscorelimiter = hardcoreHighscore
            break
        default:
            break
        }
        
        
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
                if (positionOfTouch.x < self.frame.size.width*0.12) && (positionOfTouch.y > self.frame.size.height*0.9) {
                        if tapsInGame == 0{
                            if settingsIsShown == false {
                                showSettings()
                            }
                            else if settingsIsShown == true {
                                removeSettings()
                            }
                    }
                    else if tapsInGame > 0{
                        if allowPause {
                            if (gamePaused == false) {
                                showPauseMenu()
                            }
                            else if (gamePaused == true) {
                                removePauseMenu()
                            }
                        }

                    }
                }
                else if gamePaused == true {
                    if settingsIsShown == true {
                        ///////////////////////
                        ///////////////////////
                        //////buttons//////////
                        ///////////////////////
                        ///////////////////////
                        
                        if (positionOfTouch.x > tutorialButton.position.x - 227) && (positionOfTouch.x < tutorialButton.position.x + 227) {
                            if (positionOfTouch.y > tutorialButton.position.y - 64) && (positionOfTouch.y < tutorialButton.position.y + 64) {
                                //tutorialRun()
                                settingsRun()
                            }
                        }
                        if (positionOfTouch.x > classicButton.position.x - 227) && (positionOfTouch.x < classicButton.position.x + 227) {
                            if (positionOfTouch.y > classicButton.position.y - 64) && (positionOfTouch.y < classicButton.position.y + 64) {
                                
                            }
                        }
                        
                        if (positionOfTouch.x > customizeButton.position.x - 227) && (positionOfTouch.x < customizeButton.position.x + 227) {
                            if (positionOfTouch.y > customizeButton.position.y - 64) && (positionOfTouch.y < customizeButton.position.y + 64) {
                                customizeRun()
                            }
                        }
                        
                        if (positionOfTouch.x > playGameButton.position.x - 227) && (positionOfTouch.x < playGameButton.position.x + 227) {
                            if (positionOfTouch.y > playGameButton.position.y - 64) && (positionOfTouch.y < playGameButton.position.y + 64) {
                                removeSettings()
                            }
                        }

                        
                        
                        
                    }
                }
                else if gamePaused == false{
                    if jumpcount < jumpcountRestriction{
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
                                shadowTime.invalidate()
                                cog.run(SKAction.scale(to: 0, duration: 0.2))
                                pauseSprite.run(SKAction.sequence([
                                    SKAction.wait(forDuration: 0.2),
                                    SKAction.scale(to:0.8, duration:0.1),
                                    SKAction.scale(to:1.2, duration:0.1),
                                    SKAction.scale(to:1, duration:0.1),
                                ]))
                            }
                        }
                    }
            }
            if wait == false {
                if gameover == true {
                    if (positionOfTouch.y > playGameButton.position.y-64) && (positionOfTouch.y < playGameButton.position.y+64){
                        if (positionOfTouch.x > playGameButton.position.x-227) && (positionOfTouch.x < playGameButton.position.x+227){
                            playAgain()
                            pauseback.run(SKAction.fadeOut(withDuration: 0.5))
                            playGameButton.run(SKAction.sequence([
                                SKAction.wait(forDuration: 0.0),
                                SKAction.scale(to: 1.2, duration: 0.1),
                                SKAction.scale(to: 0.8, duration: 0.1),
                                SKAction.scale(to: 0, duration: 0.1)
                                ]))

                            gameover = false
                        }
                    }
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

    
    
    
    
    var coinSpawnChance = 1
    var xRandom:CGFloat = 0
    var yRandom:CGFloat = 1
    
    var dontDraw = 0
    
    func tail() {
        
        let blueArray = [ blueBright, blueMid, blueDark, blueDark]
        
        let yellowArray = [yellowBright, yellowMid, yellowDark, yellowDark]
        
        let violetArray = [violetBright, violetMid, violetDark, violetDark]
        
    
        
        let redArray = [redBright, redMid, redDark, redDark]
        
        let greenArray = [greenBright, greenMid, greenDark, greenDark]
        
        let fuschiaArray = [fuschiaBright, fuschiaMid, fuschiaDark, fuschiaDark]
        
        let orangeArray = [orangeBright, orangeMid, orangeDark, orangeDark]
        
        let colorSetArray = [blueArray, yellowArray, violetArray, redArray, greenArray, fuschiaArray, orangeArray]
    
        
        
        
        var marquer = SKShapeNode(circleOfRadius: 25)
        let marquer2 = SKShapeNode(circleOfRadius: 15)
        let marquer3 = SKShapeNode(circleOfRadius: 15)
        
        marquer2.position = CGPoint(x:self.ball.position.x+(ball.physicsBody?.velocity.dy)!*0.03+10, y:self.ball.position.y+(ball.physicsBody?.velocity.dx)!*0.03+10)
        marquer3.position = CGPoint(x:self.ball.position.x-(ball.physicsBody?.velocity.dy)!*0.03+10, y:self.ball.position.y-(ball.physicsBody?.velocity.dx)!*0.03+10)
        
        var triPoints = [CGPoint(x: -24,y: -24), CGPoint(x: 24, y: -24), CGPoint(x: 0, y: 24), CGPoint(x: -24, y: -24)]
        
        
        switch tailType {
        case 8:
            marquer = SKShapeNode(circleOfRadius:0)
            marquer.lineWidth = 25
            break
        case 9:
            marquer = SKShapeNode(circleOfRadius:24)
            marquer.lineWidth = 25
            break
        case 10:
            marquer = SKShapeNode(rectOf: CGSize(width: 48 ,height: 48), cornerRadius: 10)
            marquer.lineWidth = 25
            break
        case 11:
            marquer = SKShapeNode(points: &triPoints, count: triPoints.count)
            marquer.lineWidth = 10
            break
        case 4:
            marquer = SKShapeNode(rectOf: CGSize(width: 10 ,height: 100), cornerRadius: 10)
            marquer.lineWidth = 25
            break
        case 5:
            marquer = SKShapeNode(circleOfRadius:24)
            marquer.lineWidth = 25
            break
        default:
            marquer = SKShapeNode(circleOfRadius:24)
            marquer.lineWidth = 25
            break
        }
        marquer.position = self.ball.position
        
        switch tailColor{
        case 8:
            marquer.strokeColor = blueArray[jumpcount]
            marquer2.strokeColor = blueArray[jumpcount]
            marquer3.strokeColor = blueArray[jumpcount]

            break
        case 9:
            marquer.strokeColor = yellowArray[jumpcount]
            marquer2.strokeColor = yellowArray[jumpcount]
            marquer3.strokeColor = yellowArray[jumpcount]

            break
        case 10:
            marquer.strokeColor = violetArray[jumpcount]
            marquer2.strokeColor = violetArray[jumpcount]
            marquer3.strokeColor = violetArray[jumpcount]

            break
        case 11:
            marquer.strokeColor = redArray[jumpcount]
            marquer2.strokeColor = redArray[jumpcount]
            marquer3.strokeColor = redArray[jumpcount]

            break
        case 4:
            marquer.strokeColor = greenArray[jumpcount]
            marquer2.strokeColor = greenArray[jumpcount]
            marquer3.strokeColor = greenArray[jumpcount]
            break
        case 5:
            marquer.strokeColor = fuschiaArray[jumpcount]
            marquer2.strokeColor = fuschiaArray[jumpcount]
            marquer3.strokeColor = fuschiaArray[jumpcount]

            break
        case 6:
            marquer.strokeColor = orangeArray[jumpcount]
            marquer2.strokeColor = orangeArray[jumpcount]
            marquer3.strokeColor = orangeArray[jumpcount]

            break
        default:
            break
        }
        marquer.zPosition = 10
        //marquer.blendMode = SKBlendMode.screen
        marquer.run(SKAction.repeatForever(SKAction.rotate(byAngle: 5, duration: 2)))
        marquer2.lineWidth = 25
        marquer2.zPosition = 10
        //marquer.blendMode = SKBlendMode.screen
        marquer2.run(SKAction.repeatForever(SKAction.rotate(byAngle: 5, duration: 2)))
        marquer3.lineWidth = 25
        marquer3.zPosition = 10
        //marquer.blendMode = SKBlendMode.screen
        marquer3.run(SKAction.repeatForever(SKAction.rotate(byAngle: 5, duration: 2)))
        if tracerStop == false {
            if dontDraw < 5 {
                dontDraw += 1
            }
            else {
                if tailType == 5 {
                    self.addChild(marquer2)
                    self.addChild(marquer3)
                }
                self.addChild(marquer)
            }
        }
        
        marquer.run(SKAction.scale(by: 0.01, duration: 2))
        marquer.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeOut(withDuration: 1),
            SKAction.removeFromParent()
        ]))
        marquer2.run(SKAction.scale(by: 0.01, duration: 2))
        marquer2.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeOut(withDuration: 1),
            SKAction.removeFromParent()
        ]))
        marquer3.run(SKAction.scale(by: 0.01, duration: 2))
        marquer3.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeOut(withDuration: 1),
            SKAction.removeFromParent()
        ]))
        
        //coinSpawnChance += 1
        xRandom += 1
        yRandom += 1
        
        if coinSpawnChance == 2 {
            //coinSpawnChance = 1
        }
        if xRandom > self.frame.size.width*0.8{
            xRandom = self.frame.size.width*0.1
        }
        if yRandom > self.frame.size.height*0.9 {
            yRandom = self.frame.size.height*0.3
        }
        
    }
    
    func miscGameLoop() {
        
        if tapsInGame == 0{
            if ball.physicsBody?.velocity == CGVector(dx: 0, dy: 1000) {
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Secondary////////
    //////Functions////////
    ///////////////////////
    
    
    func updateScore() {
        youLose.text = "\(timesTouched)"
    }
    
    func playAgain() {
        
        respawnBall()
        resetBallContact()
        respawnTarget()
        resetTargetContact()
        resetGroundContact()
        resetBorderContact()
        
        
        score = 0
        jumpcount = 0
        switch gameModes {
        case 1:
            jumpcount = 0
            highscorelimiter = beginnerHighscore
            break
        case 2:
            jumpcount = 0
            highscorelimiter = classicHighscore
            break
        case 3:
            jumpcount = -1
            highscorelimiter = hardcoreHighscore
            break
        default:
            break
        }
        timesTouched = 0
        updateScore()
        allowPause = false
        jumpPower = 1000
        tapsInGame = 0
        canHit = true
        youLose.text = ""
        shadowTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector((miscGameLoop)), userInfo: nil, repeats: true)
        
        
    }




    func respawnTarget() {
        target.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0.2),
            SKAction.rotate(toAngle: 0, duration: 0),
            SKAction.move(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.47), duration: 0),
            SKAction.scale(to:0.8, duration:0.1),
            SKAction.scale(to:1.2, duration:0.1),
            SKAction.scale(to:1, duration:0.1),

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
        ball.texture = ballTexture[0]
        ball.run(SKAction.sequence([
            SKAction.run {
                self.tracerStop = true
            },
            SKAction.scale(to: 0, duration: 0.2),
            SKAction.run {
                self.ball.position = CGPoint(x: (self.frame.size.width/2) + 2, y: (self.frame.size.height*0.25) + 2)
            },
            SKAction.rotate(toAngle: 0, duration: 0),
            SKAction.scale(to:0.8, duration:0.1),
            SKAction.scale(to:1.2, duration:0.1),
            
            SKAction.run {
                self.tracerStop = false
            },
            SKAction.scale(to:1, duration:0.1),
            ]))
        
        gameStart = true
    }
    
    func resetBallContact() {
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Border | PhysicsCategory.Platform | PhysicsCategory.ground
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Platform | PhysicsCategory.coin
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
        
        if 100 > 101{
            if highscoreConfusion {
                jumpPower = 850
                highscoreConfusion = false
            }
            else if highscoreConfusion == false {
                jumpPower = 1150
                highscoreConfusion = true
            }
        }
    }
    
    func createEmitNode(position: CGPoint, Velocity: CGVector){
        var shape = SKSpriteNode(imageNamed: "spark2")
        shape.size = CGSize(width: 25, height: 5)
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
    
    func removeInstructions(label: SKLabelNode, label2: SKLabelNode, line: SKShapeNode) {
        label.run(SKAction.fadeOut(withDuration: 1))
        label2.run(SKAction.fadeOut(withDuration: 1))
        
        line.run(SKAction.fadeOut(withDuration: 1))
    }
    
    func initializeLabel(position: CGPoint, fontColor: SKColor, fontSize: CGFloat, text: String, font: String, label: SKLabelNode, node: SKNode) {
        label.position = position
        label.fontColor = fontColor
        label.fontSize = fontSize
        label.text = text
        label.fontName = font
        label.zPosition = 100
        node.addChild(label)
    }
    
    func initializeBall() {
        ball.texture = ballTexture[0]
        ball.size = CGSize(width: 81, height: 81)
        ball.position = CGPoint(x: (self.frame.size.width/2) + 2, y: (self.frame.size.height*0.25) + 2)
        ball.physicsBody?.angularDamping = 1
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.mass = 10
        ball.physicsBody?.affectedByGravity = false
        ball.zPosition = 99
        resetBallContact()
        self.addChild(ball)
        switch costume {
        case 1:
            tophatPic.size = CGSize(width: 81, height: 81)
            tophatPic.position.y += 50
            tophatPic.zPosition = 1
            ball.addChild(tophatPic)
            break
        case 2:
            fruithatPic.size = CGSize(width: 81, height: 81)
            fruithatPic.position.y += 50
            fruithatPic.zPosition = 1
            ball.addChild(fruithatPic)
            break
        case 3:
            wartpic.size = CGSize(width: 81, height: 81)
            wartpic.zPosition = 1
            ball.addChild(wartpic)
            break
        case 4:
            vikingPic.size = CGSize(width: 81, height: 131)
            vikingPic.zPosition = 1
            ball.addChild(vikingPic)
            break
        case 5:
            spacePic.size = CGSize(width: 81, height: 81)
            spacePic.zPosition = 1
            ball.addChild(spacePic)
            break
        case 6:
            poshPic.size = CGSize(width: 81, height: 81)
            poshPic.zPosition = 1
            ball.addChild(poshPic)
            break
        case 7:
            fishPic.size = CGSize(width: 81, height: 81)
            fishPic.zPosition = 1
            ball.addChild(fishPic)
            break
        case 8:
            haloPic.size = CGSize(width: 81, height: 81)
            haloPic.zPosition = 1
            haloPic.position.y = 40
            ball.addChild(haloPic)
            break
        case 9:
            strawPic.size = CGSize(width: 81, height: 81)
            strawPic.zPosition = 1
            strawPic.position.y = 40
            ball.addChild(strawPic)
            break
        case 10:
            tiePic.size = CGSize(width: 81, height: 81)
            tiePic.zPosition = 1
            tiePic.position.y = -40
            ball.addChild(tiePic)
            break
        case 11:
            plasterPic.size = CGSize(width: 81, height: 81)
            plasterPic.zPosition = 1
            ball.addChild(plasterPic)
            break
        default:
            break
        }
        
        ball.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.7),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
    }
    
    func initializeTarget() {
        target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.47)
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
        target.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.6),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
    }
    
    func initializeGround() {
        ground.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.1)
        ground.fillColor = colorSwitch
        ground.strokeColor = colorSwitch
        ground.lineWidth = 15
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        resetGroundContact()
        self.addChild(ground)
        ground.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.8),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
    }
    
    var gamePaused = false
    var canAccessPause = false
    var velocityballsaved = CGVector(dx: 0, dy: 0)
    var velocitytargetsaved = CGVector(dx: 0, dy: 0)
    
    func showPauseMenu() {
        gamePaused = true
        pause()
        pauseback.fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
        pauseback.run(SKAction.fadeIn(withDuration: 0.5))
        self.pauseSprite.zPosition = 120
        self.pauseTimer.text = "Paused"
        self.pauseTimer2.text = "Tap the pause icon to resume"
        self.pauseTimer.fontColor = SKColor.black
        self.pauseTimer2.fontColor = SKColor.black
        velocityballsaved = (ball.physicsBody?.velocity)!
        velocitytargetsaved = (target.physicsBody?.velocity)!
        
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        target.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.affectedByGravity = false
    }
    
    func removePauseMenu(){
        unPause()
        self.gamePaused = false
        self.pauseTimer.text = ""
        self.pauseTimer2.text = ""
        self.allowPause = true
        pauseback.run(SKAction.fadeOut(withDuration: 0.5))
        ball.physicsBody?.velocity = velocityballsaved
        target.physicsBody?.velocity = velocitytargetsaved
        ball.physicsBody?.affectedByGravity = true
        
    }
    
    func pause() {
        ball.isPaused = true
        target.isPaused = true
        spark?.isPaused = true
        shadowTime.invalidate()
    }
    func unPause() {
        ball.isPaused = false
        target.isPaused = false
        spark?.isPaused = false
        shadowTime = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector((miscGameLoop)), userInfo: nil, repeats: true)
    }
    
    var gamemodeSwitch = false

    
    func showSettings() {
        

        
        pauseback.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        pauseback.run(SKAction.fadeIn(withDuration: 0.5))
        gamePaused = true
        self.pauseTimer.fontColor = colorSwitch
        self.settingsIsShown = true
        self.cog.color = SKColor.white
        
        self.pauseTimer.text = "Settings"
        
        
        switch gameModes {
        case 1:
            break
        case 2:
            
            break
        case 3:
            break
        default:
            break
        }
        
        classicButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
        customizeButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
        tutorialButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.2),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
        playGameButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            ]))
        
        self.classicLabel.text = "GameMode"
        self.customizeLabel.text = "Customize"
        self.statisticsLabel.text = "Statistics"
        self.playLabel.text = "Play"
        gamemodeSwitch = false
        youLose.text = ""
        if gameover == true {
            playAgain()
        }
        
        

    }
    
    
    
    func removeSettings() {
        
        
        gamePaused = false
        pauseback.run(SKAction.fadeOut(withDuration: 0.5))
        gamePaused = false
        self.pauseTimer.text = ""
        self.settingsIsShown = false
        
        switch gameModes {
        case 1:
            scoreLabel.text = "Beginner HighScore: " + "\(beginnerHighscore)"

            break
        case 2:
            
            jumpcountRestriction = 2
            scoreLabel.text = "Classic HighScore: " + "\(classicHighscore)"

            break
            scoreLabel.text = "Hardcore HighScore: " + "\(hardcoreHighscore)"

            break
        default:
            break
        }
        classicButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
            ]))
        customizeButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.2),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
            ]))
        tutorialButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
            ]))
        playGameButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.0),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
            ]))
    }
    
    func showGameover() {
        if self.timesTouched == 1 {
            self.youLose.text = "\(self.timesTouched)" + " Touch!"
        }
        else {
            self.youLose.text = "\(self.timesTouched)" + " Touches!"
        }
        pauseback.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        pauseback.run(SKAction.fadeIn(withDuration: 0.5))
        playGameButton.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.0),
            
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)
            
            ]))
        playLabel.run(SKAction.fadeIn(withDuration: 0.5))
        playLabel.text = "Retry"
        youLose.zPosition = 112
        playLabel.zPosition = 112
        
    }
    
    func removeGameover() {
        pauseback.run(SKAction.fadeOut(withDuration: 0.5))
        pauseback.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        playGameButton.run(SKAction.fadeOut(withDuration: 0.5))
        playLabel.run(SKAction.fadeOut(withDuration: 0.5))
        playLabel.zPosition = 101
        youLose.zPosition = 101
        playLabel.text = ""
    }
    
    
    
    
    func tutorialRun() {
        self.removeAllChildren()
        var newGame = tutorial(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    func settingsRun() {
        self.removeAllChildren()
        var newGame = Statistics(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    
    func customizeRun() {
        self.removeAllChildren()
        var newGame = customizeMenuRevamp(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    
    func changeCostume() {
        if let x = UserDefaults.standard.object(forKey: "selectedPosition4") as? Int{
            hatSelection = x
        }
        switch hatSelection {
        case 9:
            costume = 1
            break
        case 10:
            costume = 2
            break
        case 11:
            costume = 3
            break
        case 4:
            costume = 4
            break
        case 5:
            costume = 5
            break
        case 6:
            costume = 6
            break
        case 7:
            costume = 7
        case 0:
            costume = 8
            break
        case 1:
            costume = 9
            break
        case 2:
            costume = 10
            break
        case 3: costume = 11
        default:
            costume = 0
            break
        }
    }
    

    func createTextureSets() {
    
        let neutralBlue = SKTexture(imageNamed: "blueNeutral")
        let happyBlue = SKTexture(imageNamed: "blueHappy")
        let deadBlue = SKTexture(imageNamed: "blueDead")
        blueTextures.append(neutralBlue)
        blueTextures.append(happyBlue)
        blueTextures.append(deadBlue)
        
        let neutralYellow = SKTexture(imageNamed: "YellowNeutral")
        let happyYellow = SKTexture(imageNamed: "YellowHappy")
        let deadYellow = SKTexture(imageNamed: "YellowDead")
        yellowTextures.append(neutralYellow)
        yellowTextures.append(happyYellow)
        yellowTextures.append(deadYellow)
        
        let neutralViolet = SKTexture(imageNamed: "PurpleNeutral")
        let happyViolet = SKTexture(imageNamed: "PurpleHappy")
        let deadViolet = SKTexture(imageNamed: "PurpleDead")
        violetTextures.append(neutralViolet)
        violetTextures.append(happyViolet)
        violetTextures.append(deadViolet)
        
        let neutralRed = SKTexture(imageNamed: "RedNeutral")
        let happyRed = SKTexture(imageNamed: "Redhappy")
        let deadRed = SKTexture(imageNamed: "RedDead")
        redTextures.append(neutralRed)
        redTextures.append(happyRed)
        redTextures.append(deadRed)
        
        let neutralGreen = SKTexture(imageNamed: "GreenNeutral")
        let happyGreen = SKTexture(imageNamed: "GreenHappy")
        let deadGreen = SKTexture(imageNamed: "GreenDead")
        greenTextures.append(neutralGreen)
        greenTextures.append(happyGreen)
        greenTextures.append(deadGreen)
        
        let neutralFuschia = SKTexture(imageNamed: "FuschiaNeutral")
        let happyFuschia = SKTexture(imageNamed: "FushiaHappy")
        let deadFuschia = SKTexture(imageNamed: "FuschiaDead")
        fuschiaTextures.append(neutralFuschia)
        fuschiaTextures.append(happyFuschia)
        fuschiaTextures.append(deadFuschia)
        
        let neutralOrange = SKTexture(imageNamed: "OrangeNeutral")
        let happyOrange = SKTexture(imageNamed: "OrangeHappy")
        let deadOrange = SKTexture(imageNamed: "OrangeDead")
        orangeTextures.append(neutralOrange)
        orangeTextures.append(happyOrange)
        orangeTextures.append(deadOrange)

        
        
        
        

        
    }
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    

}
