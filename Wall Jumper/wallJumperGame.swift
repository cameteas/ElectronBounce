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
                        self.target.strokeColor = self.accentSwitch
                        self.target.fillColor = self.accentSwitch

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
                coinCounter += 1
                if self.coinCounter == 3 {
                    self.coinCounter = 0
                    self.respawnCoin()
                    
                }
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
                        self.spark?.particleBirthRate = 3000
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
            self.ball.texture = self.ballTexture[2]
                
        }
        
        if ((contactBody1.categoryBitMask == 2 ) && (contactBody2.categoryBitMask == 16)){
            respawnCoin()
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
    
    let smoke = SKEmitterNode (fileNamed: "smoke.sks")
    
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
    
    var particle = 0
    var blueSpray = SKTexture(imageNamed: "BlueParticle")
    var yellowSpray = SKTexture(imageNamed: "YellowParticle")
    var violetSpray = SKTexture(imageNamed: "PurpleParticle")
    var redSpray = SKTexture(imageNamed: "RedParticle")
    var greenSpray = SKTexture(imageNamed: "GreenParticle")
    var fuschiaSpray = SKTexture(imageNamed: "fuschiaParticle")
    var orangeSpray = SKTexture(imageNamed: "OrangeParticle")
    
    
    var costume = 1
    var hatSelection = 0
    
    var tophatPic = SKSpriteNode(imageNamed: "tophat")
    var fruithatPic = SKSpriteNode(imageNamed: "fruit hat")
    var wartpic = SKSpriteNode(imageNamed: "Wart")
    var vikingPic = SKSpriteNode(imageNamed: "viking")
    
    
    
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
    
    
    
    var coin = SKSpriteNode(imageNamed: "Coin")
    var coinCounter = 0
    

    
    
    
    
    
    
    
    
    
    
    ///////////////////////
    ///////////////////////
    //////Primary//////////
    //////Functions////////
    ///////////////////////

    
    
    override func didMove(to view: SKView) {
        
        initializeCoin()
        if let x = UserDefaults.standard.object(forKey: "selectedPosition1") as? Int{
            tailColor = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition2") as? Int{
            theme = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition3") as? Int{
            //selectedPosition3 = x
        }
        
        
        let colorBrightArray = [blueBright, yellowBright, violetBright, redBright, greenBright, fuschiaBright, orangeBright]
        createTextureSets()

        switch theme{
        case 8:
            ballTexture = blueTextures
            spark?.particleTexture = blueSpray
            colorSwitch = colorBrightArray[0]
            break
        case 9:
            ballTexture = yellowTextures
            spark?.particleTexture = yellowSpray
            colorSwitch = colorBrightArray[1]
            break
        case 10:
            ballTexture = violetTextures
            spark?.particleTexture = violetSpray
            colorSwitch = colorBrightArray[2]
            break
        case 11:
            ballTexture = redTextures
            spark?.particleTexture = redSpray
            colorSwitch = colorBrightArray[3]
            break
        case 4:
            ballTexture = greenTextures
            spark?.particleTexture = greenSpray
            colorSwitch = colorBrightArray[4]
            break
        case 5:
            ballTexture = fuschiaTextures
            spark?.particleTexture = fuschiaSpray
            colorSwitch = colorBrightArray[5]
            break
        case 6:
            ballTexture = orangeTextures
            spark?.particleTexture = orangeSpray
            colorSwitch = colorBrightArray[6]
            break
        default:
            ballTexture = blueTextures
            spark?.particleTexture = blueSpray
            colorSwitch = colorBrightArray[0]
            break
        }
        switch tailColor{
        case 8:
            accentSwitch = colorBrightArray[0]
            break
        case 9:
            accentSwitch = colorBrightArray[1]
            break
        case 10:
            accentSwitch = colorBrightArray[2]
            break
        case 11:
            accentSwitch = colorBrightArray[3]
            break
        case 4:
            accentSwitch = colorBrightArray[4]
            break
        case 5:
            accentSwitch = colorBrightArray[5]
            break
        case 6:
            accentSwitch = colorBrightArray[6]
            break
        default:
            accentSwitch = colorBrightArray[0]
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
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height * 0.96), fontColor: accentSwitch, fontSize: 40, text: "0", font: "Arial", label: scoreLabel)
        initializeTarget()
        initializeGround()
        initializeLabel(position:  CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.6), fontColor: colorSwitch, fontSize: 130, text: "", font: "Arial", label: youLose)
        
        
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
        
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.85), fontColor: colorSwitch, fontSize: 80, text: "", font: "arial", label: pauseTimer)
        pauseTimer.zPosition = 109
        
        initializeLabel(position: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.8), fontColor: colorSwitch, fontSize: 40, text: "", font: "arial", label: pauseTimer2)
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
            break
        case 3:
            scoreLabel.text = "Hardcore HighScore: " + "\(hardcoreHighscore)"
            break
        default:
            break
        }
        
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
        self.cog.zPosition = 110

        self.addChild(cog)
        
        classicButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        classicButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.7)
        classicButton.zPosition = 110
        classicButton.size = CGSize(width: 455, height: 135)
        
        initializeLabel(position: CGPoint(x:classicButton.position.x,y:classicButton.position.y - 20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: classicLabel)
        classicLabel.zPosition = 111
        
        customizeButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        customizeButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.55)
        customizeButton.zPosition = 110
        customizeButton.size = CGSize(width: 455, height: 135)
        
        initializeLabel(position: CGPoint(x:customizeButton.position.x,y:customizeButton.position.y - 20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: customizeLabel)
        customizeLabel.zPosition = 111
        
        tutorialButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        tutorialButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.4)
        tutorialButton.zPosition = 110
        tutorialButton.size = CGSize(width: 455, height: 135)
        
        initializeLabel(position: CGPoint(x:tutorialButton.position.x,y:tutorialButton.position.y - 20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: statisticsLabel)
        statisticsLabel.zPosition = 111
        
        playGameButton.anchorPoint = CGPoint(x:0.5, y: 0.5)
        playGameButton.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.25)
        playGameButton.zPosition = 110
        playGameButton.size = CGSize(width: 455, height: 135)
        
        initializeLabel(position: CGPoint(x:playGameButton.position.x,y:playGameButton.position.y - 20), fontColor: accentSwitch, fontSize: 60, text: "", font: "Helvetica", label: playLabel)
        playLabel.zPosition = 111
        
        pauseback.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        pauseback.fillColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        pauseback.zPosition = 108
        self.addChild(pauseback)
        
        
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
                if (positionOfTouch.x < self.frame.size.width*0.12) && (positionOfTouch.y < self.frame.size.height*0.08) {
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
                    removeSettings()
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
        
        let blueArray = [ blueBright, blueMid, blueDark, blueDark]
        
        let yellowArray = [yellowBright, yellowMid, yellowDark, yellowDark]
        
        let violetArray = [violetBright, violetMid, violetDark, violetDark]
        
        let violetArray1 = [violetBright1, violetMid1, violetDark1, violetDark1]
        
        let violetArray2 = [violetBright2, violetMid2, violetDark2, violetDark2]
        
        
        let redArray = [redBright, redMid, redDark, redDark]
        
        let greenArray = [greenBright, greenMid, greenDark, greenDark]
        
        let fuschiaArray = [fuschiaBright, fuschiaMid, fuschiaDark, fuschiaDark]
        
        let orangeArray = [orangeBright, orangeMid, orangeDark, orangeDark]
        
        let colorSetArray = [blueArray, yellowArray, violetArray, redArray, greenArray, fuschiaArray, orangeArray]
    
        
        
        
        var marquer = SKShapeNode(circleOfRadius: 25)
        var marquer2 = SKShapeNode(circleOfRadius: 15)
        var marquer3 = SKShapeNode(circleOfRadius: 15)
        marquer.position = self.ball.position
        marquer2.position = CGPoint(x:self.ball.position.x+(ball.physicsBody?.velocity.dy)!*0.03+10, y:self.ball.position.y+(ball.physicsBody?.velocity.dx)!*0.03+10)
        marquer3.position = CGPoint(x:self.ball.position.x-(ball.physicsBody?.velocity.dy)!*0.03+10, y:self.ball.position.y-(ball.physicsBody?.velocity.dx)!*0.03+10)
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
            marquer2.strokeColor = violetArray1[jumpcount]
            marquer3.strokeColor = violetArray2[jumpcount]

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
        marquer.lineWidth = 25
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
            self.addChild(marquer)
            self.addChild(marquer2)
            self.addChild(marquer3)
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
            tophatPic.zPosition = 50
            ball.addChild(tophatPic)
            break
        case 2:
            fruithatPic.size = CGSize(width: 81, height: 81)
            fruithatPic.position.y += 50
            fruithatPic.zPosition = 50
            ball.addChild(fruithatPic)
            break
        case 3:
            wartpic.size = CGSize(width: 81, height: 81)
            wartpic.zPosition = 50
            ball.addChild(wartpic)
            break
        case 4:
            vikingPic.size = CGSize(width: 81, height: 131)
            vikingPic.zPosition = 50
            ball.addChild(vikingPic)
            break
        default:
            break
        }
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
    }
    
    var ballVelocitySave = CGVector(dx: 0, dy: 0)
    var squareVelocitySave = CGVector(dx: 0, dy: 0)
    var gamePaused = false
    var canAccessPause = false
    
    func showPauseMenu() {
        gamePaused = true
        pause()
        pauseback.fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        pauseback.run(SKAction.fadeIn(withDuration: 0.5))
        self.pauseSprite.zPosition = 120
        self.pauseTimer.text = "Paused"
        self.pauseTimer2.text = "Tap the pause icon to resume"
        self.pauseTimer.fontColor = SKColor.black
        self.pauseTimer2.fontColor = SKColor.black
    }
    
    func removePauseMenu(){
        unPause()
        self.gamePaused = false
        self.pauseTimer.text = ""
        self.pauseTimer2.text = ""
        self.allowPause = true
        pauseback.run(SKAction.fadeOut(withDuration: 0.5))
        
        
    }
    
    func pause() {
        self.isPaused = true
        shadowTime.invalidate()
    }
    func unPause() {
        self.isPaused = false
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
        
        self.addChild(tutorialButton)
        switch gameModes {
        case 1:
            break
        case 2:
            self.addChild(classicButton)
            break
        case 3:
            break
        default:
            break
        }
        self.addChild(customizeButton)
        self.addChild(playGameButton)
        
        self.classicLabel.text = "GameMode"
        self.customizeLabel.text = "Customize"
        self.statisticsLabel.text = "Statistics"
        self.playLabel.text = "Play"
        gamemodeSwitch = false
        
        
        

    }
    
    func removeSettings() {
        
        gamePaused = false
        pauseback.run(SKAction.fadeOut(withDuration: 0.5))
        gamePaused = false
        self.pauseTimer.text = ""
        self.settingsIsShown = false
        tutorialButton.removeFromParent()
        switch gameModes {
        case 1:
            scoreLabel.text = "Beginner HighScore: " + "\(beginnerHighscore)"

            break
        case 2:
            classicButton.removeFromParent()
            jumpcountRestriction = 2
            scoreLabel.text = "Classic HighScore: " + "\(classicHighscore)"

            break
            scoreLabel.text = "Hardcore HighScore: " + "\(hardcoreHighscore)"

            break
        default:
            break
        }
        self.classicLabel.text = ""
        self.customizeLabel.text = ""
        self.statisticsLabel.text = ""
        self.playLabel.text = ""
        customizeButton.removeFromParent()
        playGameButton.removeFromParent()
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
    }
    
    func removeGameover() {
        pauseback.run(SKAction.fadeOut(withDuration: 0.5))
    }
    
    
    
    
    func tutorialRun() {
        self.removeAllChildren()
        var newGame = tutorial(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    
    func customizeRun() {
        self.removeAllChildren()
        var newGame = customizeMenu(size: self.size)
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
        let happyFuschia = SKTexture(imageNamed: "Fuschiahappy")
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
    
    
    
    func initializeCoin() {
        coin.size = CGSize(width: 50, height: 50)
        coin.zPosition = 101
        coin.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        coin.alpha = 0
        coin.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.categoryBitMask = PhysicsCategory.None
        coin.physicsBody?.contactTestBitMask = PhysicsCategory.None
        coin.physicsBody?.collisionBitMask = PhysicsCategory.None
        //self.addChild(coin)
    }
    
    func respawnCoin() {
        self.coin.run(SKAction.sequence([
            SKAction.run {
                self.coin.physicsBody?.categoryBitMask = PhysicsCategory.None
                self.coin.physicsBody?.contactTestBitMask = PhysicsCategory.None
                self.coin.physicsBody?.collisionBitMask = PhysicsCategory.None
            },
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
        ]))
        let coinChance:UInt32 = arc4random_uniform(UInt32(3))
        let coinStat:CGFloat = CGFloat(coinChance)
        if coinStat == 1 {
            var coinPosition = CGPoint(x:0,y:0)
            var chooseRandom = true
            while chooseRandom == true {
                let randomNum:UInt32 = arc4random_uniform(UInt32(100))
                let randomNum2:UInt32 = arc4random_uniform(UInt32(300))
                
                let randomX:CGFloat = CGFloat(randomNum)
                let randomY:CGFloat = CGFloat(randomNum2)
                
                //if (randomX < self.ball.position.x + 25) && (randomX > self.ball.position.x - 25) && (randomY < self.ball.position.y + 25) && (randomY > self.ball.position.y - 25) {
                    
                //}
                //else {
                    chooseRandom = false
                    coinPosition = CGPoint(x:randomX ,y:randomY)
                    coin.position = coinPosition
                //}
            }
        }
        
        coin.alpha = 1
        coin.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1),
            SKAction.run {
                self.coin.physicsBody?.categoryBitMask = PhysicsCategory.coin
                self.coin.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                self.coin.physicsBody?.collisionBitMask = PhysicsCategory.None
            }
            ]))
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
