//
//  customizeMenuRevamp.swift
//  Wall Jumper
//
//  Created by Cameron Teasdale on 2017-02-18.
//  Copyright © 2017 Cameron Teasdale. All rights reserved.
//

import Foundation
import SpriteKit


class customizeMenuRevamp: SKScene {




    var boxSelected = 1
    var positionOfInitialTouch = CGPoint(x: 0, y: 0)
    var positionOfMovedTouch = CGPoint(x: 0, y: 0)
    var positionOfMovedTouchSaved = CGPoint(x: 0, y: 0)
    var positionOfEndedTouch = CGPoint(x:0, y: 0)
    var firsTouch = true
    
    var frame1 = SKNode()
    var frame2 = SKNode()
    var frame3 = SKNode()
    var frame4 = SKNode()

    var frameNum = 1
    var isSwiped = false
    
    var page1Display = SKShapeNode(circleOfRadius: 20)
    var page2Display = SKShapeNode(circleOfRadius: 10)
    var page3Display = SKShapeNode(circleOfRadius: 10)
    var page4Display = SKShapeNode(circleOfRadius: 10)
    
    var tailLabel = SKLabelNode(fontNamed: "Helvetica")
    var themeLabel = SKLabelNode(fontNamed: "Helvetica")
    var particleLabel = SKLabelNode(fontNamed: "Helvetica")
    var hatLabel = SKLabelNode(fontNamed: "Helvetica")
    
    var blueTail = SKSpriteNode(imageNamed: "BlueParticle")
    var yellowTail = SKSpriteNode(imageNamed: "YellowParticle")
    var purpleTail = SKSpriteNode(imageNamed: "PurpleParticle")
    var redTail = SKSpriteNode(imageNamed: "RedParticle")
    var greenTail = SKSpriteNode(imageNamed: "GreenParticle")
    var fuschiaTail = SKSpriteNode(imageNamed: "FuschiaParticle")
    var orangeTail = SKSpriteNode(imageNamed: "OrangeParticle")
    
    var blueCharacter = SKSpriteNode(imageNamed: "blueNeutral")
    var yellowCharacter = SKSpriteNode(imageNamed: "YellowNeutral")
    var purpleCharacter = SKSpriteNode(imageNamed: "PurpleNeutral")
    var redCharacter = SKSpriteNode(imageNamed: "RedNeutral")
    var greenCharacter = SKSpriteNode(imageNamed: "GreenNeutral")
    var fuschiaCharacter = SKSpriteNode(imageNamed: "FuschiaNeutral")
    var orangeCharacter = SKSpriteNode(imageNamed: "OrangeNeutral")
    
    var simpleCircle = SKSpriteNode(imageNamed: "basicCircle")
    var simpleSquare = SKSpriteNode(imageNamed: "basicSquare")
    var simpleTriangle = SKSpriteNode(imageNamed: "basicTri")
    var simpleLine = SKSpriteNode(imageNamed: "Line")
    var threecircle = SKSpriteNode(imageNamed: "trippleCircle")
    var threeSquare = SKSpriteNode(imageNamed: "trippleSquare")
    var bigTri = SKSpriteNode(imageNamed: "LargeTri")
    var threeLine = SKSpriteNode(imageNamed: "trippleLine")
    var fire = SKSpriteNode(imageNamed: "bubble")
    var quadBox = SKSpriteNode(imageNamed: "QuadSquare")
    var arrowLine = SKSpriteNode(imageNamed: "arrow")
    
    var blueTextures:Array<SKTexture> = []
    var yellowTextures:Array<SKTexture> = []
    var violetTextures:Array<SKTexture> = []
    var redTextures:Array<SKTexture> = []
    var greenTextures:Array<SKTexture> = []
    var fuschiaTextures:Array<SKTexture> = []
    var orangeTextures:Array<SKTexture> = []
    
    var ballTexture: Array<SKTexture> = []
    
    var ball = SKSpriteNode(imageNamed: "blueNeutral")
    var ball2 = SKSpriteNode(imageNamed: "blueNeutral")
    
    var blueSpray = SKSpriteNode(imageNamed: "BlueParticle")
    
    var tophatPic = SKSpriteNode(imageNamed: "tophat")
    var molePic = SKSpriteNode(imageNamed: "Wart")
    var fruitHatPic = SKSpriteNode(imageNamed: "fruit hat")
    var vikingHatPic = SKSpriteNode(imageNamed: "viking")
    var spacePic = SKSpriteNode(imageNamed: "spaceSuit")
    var poshPic = SKSpriteNode(imageNamed: "posh")
    var fishPic = SKSpriteNode(imageNamed: "fishbowl")
    var haloPic = SKSpriteNode(imageNamed: "halo")
    var strawPic = SKSpriteNode(imageNamed: "strawhat")
    var tiePic = SKSpriteNode(imageNamed: "tie")
    var plasterPic = SKSpriteNode(imageNamed: "plaster mask")
    
    let selected1 = SKSpriteNode(imageNamed: "SelectedBox")
    let selected2 = SKSpriteNode(imageNamed: "SelectedBox")
    let selected3 = SKSpriteNode(imageNamed: "SelectedBox")
    let selected4 = SKSpriteNode(imageNamed: "SelectedBox")
    
    
    var grayArray:Array<SKColor> = []
    var blueArray:Array<SKColor> = []
    var yellowArray:Array<SKColor> = []
    var violetArray:Array<SKColor> = []
    var redArray:Array<SKColor> = []
    var greenArray:Array<SKColor> = []
    var fuschiaArray:Array<SKColor> = []
    var orangeArray:Array<SKColor> = []
    var colorBrightArray:Array<UIColor> = []
    
    var boxPoints:Array<CGPoint> = []
    
    var boxList1:Array<SKSpriteNode> = []
    var boxList2:Array<SKSpriteNode> = []
    var boxList3:Array<SKSpriteNode> = []
    var boxList4:Array<SKSpriteNode> = []
    var boxListList: Array<Array<SKSpriteNode>> = []

    var unlockList1: Array<Int> = [0,0,0,0,0,0,0,0,1,0,0,0]
    var unlockList2: Array<Int> = [0,0,0,0,0,0,0,0,1,0,0,0]
    var unlockList3: Array<Int> = [0,0,0,0,0,0,0,0,1,1,0,0]
    var unlockList4: Array<Int> = [0,0,0,0,0,0,0,0,1,1,0,0]
    
    var classicHighScore = 0
    var mainColor = 0
    var accentColor = 0
    var tail = 0
    var hat = 0
    var coins = 0
    
    var colorSwitch = SKColor.white
    var accentSwitch = SKColor.white
    
    var timer = Timer()
    var activeFrame = SKNode()
    
    override func didMove(to view: SKView) {
        loadValues()
        importColors()
        createTextureSets()
        findColors()
        
        activeFrame = frame1
        //timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector((trail)), userInfo: nil, repeats: true)
        
        
        self.backgroundColor = grayArray[3]
        frame1.position = CGPoint(x:self.frame.size.width*0, y:self.frame.size.height*0)
        frame2.position = CGPoint(x:self.frame.size.width*1.5, y:self.frame.size.height*0)
        frame3.position = CGPoint(x:self.frame.size.width*1.5, y:self.frame.size.height*0)
        frame4.position = CGPoint(x:self.frame.size.width*1.5, y:self.frame.size.height*0)
        
        
        self.addChild(frame1)
        self.addChild(frame2)
        self.addChild(frame3)
        self.addChild(frame4)
        
        page1Display.fillColor = colorSwitch
        page1Display.position = CGPoint(x: self.frame.size.width*0.41, y: self.frame.size.height*0.04)
        page1Display.strokeColor = grayArray[3]
        page1Display.zPosition = 20
        self.addChild(page1Display)
        page2Display.fillColor = grayArray[3]
        page2Display.position = CGPoint(x: self.frame.size.width*0.47, y: self.frame.size.height*0.04)
        page2Display.strokeColor = grayArray[3]
        page2Display.zPosition = 20
        self.addChild(page2Display)
        page3Display.fillColor = grayArray[3]
        page3Display.position = CGPoint(x: self.frame.size.width*0.53, y: self.frame.size.height*0.04)
        page3Display.strokeColor = grayArray[3]
        page3Display.zPosition = 20
        self.addChild(page3Display)
        page4Display.fillColor = grayArray[3]
        page4Display.position = CGPoint(x: self.frame.size.width*0.59, y: self.frame.size.height*0.04)
        page4Display.strokeColor = grayArray[3]
        page4Display.zPosition = 20
        self.addChild(page4Display)
        
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: colorSwitch, fontSize: 70, text: "Accent Colour", label: tailLabel, frame: frame2)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: colorSwitch, fontSize: 70, text: "Main Colour", label: themeLabel, frame: frame1)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: colorSwitch, fontSize: 70, text: "Tail", label: particleLabel, frame: frame3)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: colorSwitch, fontSize: 70, text: "Hat", label: hatLabel, frame: frame4)
        
        let frameList = [frame1, frame2, frame3, frame4]
        
        for frame in frameList {
            createBacking(frame: frame)
        }
        findPoints()
        for frame in frameList {
            for points in boxPoints {
                createBox(Position: points, frame: frame)
            }
        }
        
        createLocks()
        
        selected1.zPosition = 30
        selected2.zPosition = 30
        selected3.zPosition = 30
        selected4.zPosition = 30
        
        selected1.size = boxList1[0].size
        selected2.size = boxList1[0].size
        selected3.size = boxList1[0].size
        selected4.size = boxList1[0].size
        
        boxList1[mainColor].addChild(selected1)
        boxList2[accentColor].addChild(selected2)
        boxList3[tail].addChild(selected3)
        boxList4[hat].addChild(selected4)
        
        ball.size = CGSize(width: 200, height: 200)
        ball.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.7)
        frame1.addChild(ball)
        ball.texture = ballTexture[0]
        
        ball2.size = CGSize(width: 200, height: 200)
        ball2.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.7)
        frame4.addChild(ball2)
        ball2.texture = ballTexture[0]
        
        wearHat()
        }
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfInitialTouch = touch.location(in: self)
            
            
            if positionOfInitialTouch.y > self.frame.size.height*0.9 {
                returnToGame()
            }
 
        }

    }
    
    var trailColor = 0
    var trailCount = 0
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            positionOfMovedTouchSaved = positionOfMovedTouch
            positionOfMovedTouch = touch.location(in: self)
            if (positionOfMovedTouch.y > self.frame.size.height/2) && (activeFrame == frame2) || (positionOfMovedTouch.y > self.frame.size.height/2) && (activeFrame == frame3) {
                if trailCount == 2 {
                    trail(x:trailColor)
                    trailCount = 0
                }
                else {
                    trailCount += 1
                }
            }
            else {
                if firsTouch {
                    firsTouch = false
                }
                else{
                    touchMovedSwipe()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        firsTouch = true
        touchEndedSwipe()
        if isSwiped == false {
            var cycleCounter = 0
            for box in boxPoints {
                if positionOfInitialTouch.x > box.x - 70 {
                    if positionOfInitialTouch.x < box.x + 70 {
                        if positionOfInitialTouch.y > box.y - 70 {
                            if positionOfInitialTouch.y < box.y + 70 {
                                switch frameNum {
                                case 1:
                                    
                                    boxList1[cycleCounter].run(SKAction.sequence([
                                        SKAction.rotate(toAngle: 0.3 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.3 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.2 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.2 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.1 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.1 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.05 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.05 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.01 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.01 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0, duration: 0.1),
                                        ]))
                                    
                                    if unlockList1[cycleCounter] == 1{
                                        
                                        selected1.removeFromParent()
                                        boxList1[cycleCounter].addChild(selected1)
                                        mainColor = cycleCounter
                                        UserDefaults.standard.set(mainColor, forKey: "selectedPosition1")
                                        findColors()
                                        
                                        
                                        
                                        page1Display.fillColor = colorSwitch
                                        page2Display.fillColor = grayArray[3]
                                        page3Display.fillColor = grayArray[3]
                                        page4Display.fillColor = grayArray[3]
                                        
                                        
                                        themeLabel.fontColor = colorSwitch
                                        particleLabel.fontColor = colorSwitch
                                        tailLabel.fontColor = colorSwitch
                                        hatLabel.fontColor = colorSwitch
                                        
                                    }
                                    ball2.texture = ballTexture[0]
                                    ball.texture = ballTexture[0]
                                    
                                    break
                                case 2:
                                    boxList2[cycleCounter].run(SKAction.sequence([
                                        SKAction.rotate(toAngle: 0.3 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.3 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.2 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.2 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.1 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.1 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.05 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.05 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.01 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.01 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0, duration: 0.1),
                                        ]))
                                    
                                    if unlockList2[cycleCounter] == 1{
                                        
                                        selected2.removeFromParent()
                                        boxList2[cycleCounter].addChild(selected2)
                                        accentColor = cycleCounter
                                        UserDefaults.standard.set(accentColor, forKey: "selectedPosition2")
                                    }
                                    break
                                case 3:
                                    
                                    boxList3[cycleCounter].run(SKAction.sequence([
                                        SKAction.rotate(toAngle: 0.3 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.3 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.2 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.2 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.1 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.1 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.05 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.05 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.01 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.01 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0, duration: 0.1),
                                        ]))
                                    
                                    if unlockList3[cycleCounter] == 1{
                                        selected3.removeFromParent()
                                        boxList3[cycleCounter].addChild(selected3)
                                        tail = cycleCounter
                                        UserDefaults.standard.set(tail, forKey: "selectedPosition3")
                                    }
                                    break
                                case 4:
                                    
                                    boxList4[cycleCounter].run(SKAction.sequence([
                                        SKAction.rotate(toAngle: 0.3 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.3 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.2 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.2 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.1 + variance, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.1 - variance, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.05 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.05 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0.01 + variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: -0.01 - variance/2, duration: 0.1),
                                        SKAction.rotate(toAngle: 0, duration: 0.1),
                                        ]))
                                    
                                    if unlockList4[cycleCounter] == 1{
                                        removeHat()
                                        selected4.removeFromParent()
                                        boxList4[cycleCounter].addChild(selected4)
                                        hat = cycleCounter
                                        UserDefaults.standard.set(hat, forKey: "selectedPosition4")
                                        wearHat()
                                    }
                                    
                                    break
                                default:
                                    break
                                }
                                
                            }
                        }
                    }
                }
                cycleCounter += 1
            }
        }
        if isSwiped == true {
            isSwiped = false
        }
        if trailColor != 2 {
            trailColor += 1
        }
        else {
            trailColor = 0
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func touchMovedSwipe() {
        switch frameNum {
        case 1:
            frame1.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            frame2.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            break
        case 2:
            frame1.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            frame2.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            frame3.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            break
        case 3:
            frame2.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            frame3.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            frame4.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            break
        case 4:
            frame3.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            frame4.position.x += positionOfMovedTouch.x - positionOfMovedTouchSaved.x
            break
        default:
            break
        }
    }

    
    
    func touchEndedSwipe() {
        switch frameNum {
        case 1:
            if frame1.position.x > self.frame.size.width*0.1 {
                frame1.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
            }
            else if frame1.position.x < self.frame.size.width*(-0.1){
                frame1.run(SKAction.move(to: CGPoint(x: self.frame.size.width*(-1.5), y: self.frame.size.height*0), duration: 0.1))
                frame2.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 2
                page1Display.fillColor = grayArray[3]
                page2Display.fillColor = colorSwitch
                page3Display.fillColor = grayArray[3]
                page4Display.fillColor = grayArray[3]
                page1Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page2Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: boxList2)
                activeFrame = frame2
            }
            else {
                frame1.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.1))
            }
            break
        case 2:
            if frame2.position.x > self.frame.size.width*0.1 {
                frame2.run(SKAction.move(to: CGPoint(x: self.frame.size.width*1.5, y: self.frame.size.height*0), duration: 0.1))
                frame1.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 1
                page1Display.fillColor = colorSwitch
                page2Display.fillColor = grayArray[3]
                page3Display.fillColor = grayArray[3]
                page4Display.fillColor = grayArray[3]
                page2Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page1Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: boxList1)
                activeFrame = frame1
                
                
            }
            else if frame2.position.x < self.frame.size.width*(-0.1){
                frame2.run(SKAction.move(to: CGPoint(x: self.frame.size.width*(-1.5), y: self.frame.size.height*0), duration: 0.1))
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 3
                page1Display.fillColor = grayArray[3]
                page2Display.fillColor = grayArray[3]
                page3Display.fillColor = colorSwitch
                page4Display.fillColor = grayArray[3]
                page2Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page3Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: boxList3)
                activeFrame = frame3
            }
            else {
                frame2.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
            }
            break
        case 3:
            if frame3.position.x > self.frame.size.width*0.1 {
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*1.5, y: self.frame.size.height*0), duration: 0.1))
                frame2.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 2
                page1Display.fillColor = grayArray[3]
                page2Display.fillColor = colorSwitch
                page3Display.fillColor = grayArray[3]
                page4Display.fillColor = grayArray[3]
                page3Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page2Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: boxList2)
                activeFrame = frame2
                
            }
            else if frame3.position.x < self.frame.size.width*(-0.1){
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*(-1.5), y: self.frame.size.height*0), duration: 0.1))
                frame4.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 4
                page1Display.fillColor = grayArray[3]
                page2Display.fillColor = grayArray[3]
                page3Display.fillColor = grayArray[3]
                page4Display.fillColor = colorSwitch
                page3Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page4Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: boxList4)
                activeFrame = frame4
            }
            else {
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
            }
            break
        case 4:
            if frame4.position.x > self.frame.size.width*0.1 {
                frame4.run(SKAction.move(to: CGPoint(x: self.frame.size.width*1.5, y: self.frame.size.height*0), duration: 0.1))
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 3
                page1Display.fillColor = grayArray[3]
                page2Display.fillColor = grayArray[3]
                page3Display.fillColor = colorSwitch
                page4Display.fillColor = grayArray[3]
                page4Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page3Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: boxList3)
                activeFrame = frame3
            }
            else if frame4.position.x < self.frame.size.width*(-0.1){
                frame4.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
            }
            else {
                frame4.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
            }
            break
        default:
            break
        }
    }

    
    var variance:CGFloat = 0
    
    func wiggle(itemBoxlist: Array<SKSpriteNode>) {
        for box in itemBoxlist {
            //variance += 0.05
            
            box.run(SKAction.sequence([
                SKAction.rotate(toAngle: 0.3 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.3 - variance, duration: 0.1),
                SKAction.rotate(toAngle: 0.2 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.2 - variance, duration: 0.1),
                SKAction.rotate(toAngle: 0.1 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.1 - variance, duration: 0.1),
                SKAction.rotate(toAngle: 0.05 + variance/2, duration: 0.1),
                SKAction.rotate(toAngle: -0.05 - variance/2, duration: 0.1),
                SKAction.rotate(toAngle: 0.01 + variance/2, duration: 0.1),
                SKAction.rotate(toAngle: -0.01 - variance/2, duration: 0.1),
                SKAction.rotate(toAngle: 0, duration: 0.1),
                ]))
        }
    }
    
    
    
    func initializeLabel(position: CGPoint, fontColor: SKColor, fontSize: CGFloat, text: String, label: SKLabelNode, frame: SKNode) {
        label.position = position
        label.fontColor = fontColor
        label.fontSize = fontSize
        label.text = text
        label.zPosition = 20
        frame.addChild(label)
    }
    
    
    
    
    
    func returnToGame() {
        frame1.run(SKAction.sequence([
            SKAction.run {
                self.switchgame()
            }
            ]))
    }
    
    
    
    func switchgame() {
        UserDefaults.standard.set(unlockList1, forKey: "unlockList1")
        UserDefaults.standard.set(unlockList2, forKey: "unlockList2")
        UserDefaults.standard.set(unlockList3, forKey: "unlockList3")
        UserDefaults.standard.set(unlockList4, forKey: "unlockList4")
        UserDefaults.standard.set(coins, forKey: "coins")
        
        self.removeAllChildren()
        let newGame = wallJumperGame(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    
    
    
    
    
    
    
    func importColors() {
        
        let grayDark = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
        let grayMid = UIColor(red: 33/255, green: 33/255, blue: 34/255, alpha: 1)
        let grayMidLight = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        let grayLight = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
        
        
        let blueBright = UIColor(red: 0, green: 223/255, blue: 252/255, alpha: 1)
        let blueMid = UIColor(red: 0, green: 140/255, blue: 158/255, alpha: 1)
        let blueDark = UIColor(red: 0, green: 50/255, blue: 60/255, alpha: 1)
        
        let yellowBright = UIColor(red: 234/255, green: 220/255, blue: 0/255, alpha: 1)
        let yellowMid = UIColor(red: 161/255, green: 151/255, blue: 0/255, alpha: 1)
        let yellowDark = UIColor(red: 102/255, green: 96/255, blue: 0/255, alpha: 1)
        
        let violetBright = UIColor(red: 167/255, green: 109/255, blue: 251/255, alpha: 1)
        let violetMid = UIColor(red: 111/255, green: 73/255, blue: 167/255, alpha: 1)
        let violetDark = UIColor(red: 70/255, green: 46/255, blue: 106/255, alpha: 1)
        
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
        
        
        grayArray = [grayLight, grayMidLight, grayMid, grayDark]
        blueArray = [ blueBright, blueMid, blueDark, blueDark]
        yellowArray = [yellowBright, yellowMid, yellowDark, yellowDark]
        violetArray = [violetBright, violetMid, violetDark, violetDark]
        redArray = [redBright, redMid, redDark, redDark]
        greenArray = [greenBright, greenMid, greenDark, greenDark]
        fuschiaArray = [fuschiaBright, fuschiaMid, fuschiaDark, fuschiaDark]
        orangeArray = [orangeBright, orangeMid, orangeDark, orangeDark]
        colorBrightArray = [blueBright, yellowBright, violetBright, redBright, greenBright, fuschiaBright, orangeBright]
    }
    
    
    
    
    
    
    
    
    func createBacking(frame: SKNode) {
        let frameBackingTop = SKShapeNode(rectOf: CGSize(width: self.frame.size.width, height: self.frame.size.height*0.125), cornerRadius: 10)
        frameBackingTop.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.945)
        frameBackingTop.fillColor = grayArray[2]
        frameBackingTop.lineWidth = 0
        frameBackingTop.zPosition = 10
        frame.addChild(frameBackingTop)
        
        let frameBackingBottom = SKShapeNode(rectOf: CGSize(width: self.frame.size.width, height: self.frame.size.height*0.52), cornerRadius: 10)
        frameBackingBottom.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.24)
        frameBackingBottom.fillColor = grayArray[2]
        frameBackingBottom.lineWidth = 0
        frameBackingBottom.zPosition = 10
        frame.addChild(frameBackingBottom)
    }
    
    
    
    
    
    
    
    
    
    func findPoints() {
        
        var findPoints = true
        var xCount:CGFloat = 1
        var yCount:CGFloat = 1
        var xMult: CGFloat = 0.13
        let yMult: CGFloat = 0.14
        
        
        while findPoints == true{
            if yCount > 1 {
                //yMult = 0.085
            }
            if yCount > 3 {
                //yMult = 0.078
            }
            boxPoints.append(CGPoint(x: (self.frame.size.width*xMult)*xCount, y: (self.frame.size.height*yMult)*yCount))
            
            
            xCount += 2
            xMult = 0.125
            
            if xCount == 9 {
                xMult = 0.13
                
                xCount = 1
                yCount += 1
                //yCount += 2
            }
            if yCount == 4 {
                findPoints = false
            }
        }
    }
   
    
    
    
    
    
    
    
    
    func createBox(Position: CGPoint, frame:SKNode) {
        //let Backbox = SKShapeNode(rectOf: CGSize(width: 155, height: 155), cornerRadius: 10)
        let Backbox = SKSpriteNode(imageNamed: "Unselected Box")
        Backbox.size = CGSize(width: 140, height: 140)
        Backbox.position = Position
        //Backbox.fillColor = SKColor.gray
        //Backbox.lineWidth = 0
        Backbox.zPosition = 20
        frame.addChild(Backbox)
        switch frame {
        case frame1:
            boxList1.append(Backbox)
            break
        case frame2:
            boxList2.append(Backbox)
            break
        case frame3:
            boxList3.append(Backbox)
            break
        case frame4:
            boxList4.append(Backbox)
            break
        default:
            break
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    func createLocks() {
        
        func page1() {
            blueCharacter.size = CGSize(width: 120, height: 120)
            blueCharacter.zPosition = 110
            unlockList1[8] = 1
            boxList1[8].addChild(blueCharacter)
            if classicHighScore > 10 {
                yellowCharacter.size = CGSize(width: 120, height: 120)
                yellowCharacter.zPosition = 110
                unlockList1[9] = 1
                boxList1[9].addChild(yellowCharacter)
                if classicHighScore > 10 {
                    purpleCharacter.size = CGSize(width: 120, height: 120)
                    purpleCharacter.zPosition = 110
                    unlockList1[10] = 1
                    boxList1[10].addChild(purpleCharacter)
                    if classicHighScore > 10 {
                        redCharacter.size = CGSize(width: 120, height: 120)
                        redCharacter.zPosition = 110
                        unlockList1[11] = 1
                        boxList1[11].addChild(redCharacter)
                        if classicHighScore > 10 {
                            greenCharacter.size = CGSize(width: 120, height: 120)
                            greenCharacter.zPosition = 110
                            unlockList1[4] = 1
                            boxList1[4].addChild(greenCharacter)
                            if classicHighScore > 10 {
                                fuschiaCharacter.size = CGSize(width: 120, height: 120)
                                fuschiaCharacter.zPosition = 110
                                unlockList1[5] = 1
                                boxList1[5].addChild(fuschiaCharacter)
                                if classicHighScore > 10 {
                                    orangeCharacter.size = CGSize(width: 120, height: 120)
                                    orangeCharacter.zPosition = 110
                                    unlockList1[6] = 1
                                    boxList1[6].addChild(orangeCharacter)
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        func page2() {
            blueTail.size = CGSize(width: 120, height: 120)
            blueTail.zPosition = 110
            unlockList2[8] = 1
            boxList2[8].addChild(blueTail)
            if classicHighScore > 10 {
                yellowTail.size = CGSize(width: 120, height: 120)
                yellowTail.zPosition = 110
                unlockList2[9] = 1
                boxList2[9].addChild(yellowTail)
                if classicHighScore > 10 {
                    purpleTail.size = CGSize(width: 120, height: 120)
                    purpleTail.zPosition = 110
                    unlockList2[10] = 1
                    boxList2[10].addChild(purpleTail)
                    if classicHighScore > 10 {
                        redTail.size = CGSize(width: 120, height: 120)
                        redTail.zPosition = 110
                        unlockList2[11] = 1
                        boxList2[11].addChild(redTail)
                        if classicHighScore > 10 {
                            greenTail.size = CGSize(width: 120, height: 120)
                            greenTail.zPosition = 110
                            unlockList2[4] = 1
                            boxList2[4].addChild(greenTail)
                            if classicHighScore > 10 {
                                fuschiaTail.size = CGSize(width: 120, height: 120)
                                fuschiaTail.zPosition = 110
                                unlockList2[5] = 1
                                boxList2[5].addChild(fuschiaTail)
                                if classicHighScore > 10 {
                                    orangeTail.size = CGSize(width: 120, height: 120)
                                    orangeTail.zPosition = 110
                                    unlockList2[6] = 1
                                    boxList2[6].addChild(orangeTail)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        func page3() {
            
            simpleCircle.size = CGSize(width: 120, height: 120)
            simpleCircle.zPosition = 110
            unlockList3[9] = 1
            boxList3[9].addChild(simpleCircle)
            if classicHighScore > 1 {
                simpleSquare.size = CGSize(width: 120, height: 120)
                simpleSquare.zPosition = 110
                unlockList3[10] = 1
                boxList3[10].addChild(simpleSquare)
                if classicHighScore > 1 {
                    simpleTriangle.size = CGSize(width: 120, height: 120)
                    simpleTriangle.zPosition = 110
                    unlockList3[11] = 1
                    boxList3[11].addChild(simpleTriangle)
                    if classicHighScore > 1 {
                        simpleLine.size = CGSize(width: 120, height: 120)
                        simpleLine.zPosition = 110
                        unlockList3[4] = 1
                        boxList3[4].addChild(simpleLine)
                        if classicHighScore > 1 {
                            threecircle.size = CGSize(width: 120, height: 120)
                            threecircle.zPosition = 110
                            unlockList3[5] = 1
                            boxList3[5].addChild(threecircle)
                            if classicHighScore > 1 {
                                threeSquare.size = CGSize(width: 120, height: 120)
                                threeSquare.zPosition = 110
                                unlockList3[6] = 1
                                boxList3[6].addChild(threeSquare)
                                if classicHighScore > 1 {
                                    bigTri.size = CGSize(width: 120, height: 120)
                                    bigTri.zPosition = 110
                                    unlockList3[7] = 1
                                    boxList3[7].addChild(bigTri)
                                    if classicHighScore > 1 {
                                        threeLine.size = CGSize(width: 120, height: 120)
                                        threeLine.zPosition = 110
                                        unlockList3[0] = 1
                                        boxList3[0].addChild(threeLine)
                                        if classicHighScore > 1 {
                                            fire.size = CGSize(width: 120, height: 120)
                                            fire.zPosition = 110
                                            unlockList3[1] = 1
                                            boxList3[1].addChild(fire)
                                            if classicHighScore > 1 {
                                                quadBox.size = CGSize(width: 120, height: 120)
                                                quadBox.zPosition = 110
                                                unlockList3[2] = 1
                                                boxList3[2].addChild(quadBox)
                                                if classicHighScore > 1 {
                                                    arrowLine.size = CGSize(width: 120, height: 120)
                                                    arrowLine.zPosition = 110
                                                    unlockList3[3] = 1
                                                    boxList3[3].addChild(arrowLine)
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        func page4() {
            if classicHighScore > 10 {
                tophatPic.size = CGSize(width: 120, height: 120)
                tophatPic.zPosition = 110
                unlockList4[9] = 1
                boxList4[9].addChild(tophatPic)
                if classicHighScore > 10 {
                    fruitHatPic.size = CGSize(width: 120, height: 120)
                    fruitHatPic.zPosition = 110
                    unlockList4[10] = 1
                    boxList4[10].addChild(fruitHatPic)
                    if classicHighScore > 10 {
                        molePic.size = CGSize(width: 120, height: 120)
                        molePic.zPosition = 110
                        unlockList4[11] = 1
                        boxList4[11].addChild(molePic)
                        if classicHighScore > 10 {
                            vikingHatPic.size = CGSize(width: 81, height: 131)
                            vikingHatPic.zPosition = 110
                            unlockList4[4] = 1
                            boxList4[4].addChild(vikingHatPic)
                        }
                        if classicHighScore > 10 {
                            spacePic.size = CGSize(width: 81, height: 81)
                            spacePic.zPosition = 110
                            unlockList4[5] = 1
                            boxList4[5].addChild(spacePic)
                            if classicHighScore > 10 {
                                poshPic.size = CGSize(width: 81, height: 81)
                                poshPic.zPosition = 110
                                unlockList4[6] = 1
                                boxList4[6].addChild(poshPic)
                                if classicHighScore > 10 {
                                    fishPic.size = CGSize(width: 81, height: 81)
                                    fishPic.zPosition = 110
                                    unlockList4[7] = 1
                                    boxList4[7].addChild(fishPic)
                                    if classicHighScore > 10 {
                                        haloPic.size = CGSize(width: 81, height: 81)
                                        haloPic.zPosition = 110
                                        unlockList4[0] = 1
                                        boxList4[0].addChild(haloPic)
                                        if classicHighScore > 10 {
                                            strawPic.size = CGSize(width: 81, height: 81)
                                            strawPic.zPosition = 110
                                            unlockList4[1] = 1
                                            boxList4[1].addChild(strawPic)
                                            if classicHighScore > 10 {
                                                tiePic.size = CGSize(width: 81, height: 81)
                                                tiePic.zPosition = 110
                                                unlockList4[2] = 1
                                                boxList4[2].addChild(tiePic)
                                                if classicHighScore > 10 {
                                                    plasterPic.size = CGSize(width: 81, height: 81)
                                                    plasterPic.zPosition = 110
                                                    unlockList4[3] = 1
                                                    boxList4[3].addChild(plasterPic)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
       
        page1()
        page2()
        page3()
        page4()
        let coinDark = UIColor(red: 211/255, green: 144/255, blue: 48/255, alpha: 1)
        var x = 0
        
        for locks in boxList1 {
            
            if unlockList1[x] == 1 {
               
            }
            else {
                let lock = SKSpriteNode(imageNamed: "Lock")
                lock.size = CGSize(width: 70, height: 70)
                lock.position = CGPoint(x: 0 , y: 20)
                lock.zPosition = 111
                boxList1[x].addChild(lock)
                let monetaryValue = SKLabelNode(fontNamed: "Helvetica")
                initializeLabel(position: CGPoint(x: 0, y: -60), fontColor: coinDark, fontSize: 50, text: "100", label: monetaryValue, frame: frame1)
                monetaryValue.removeFromParent()
                monetaryValue.zPosition = 150
                boxList1[x].addChild(monetaryValue)
            }
            x += 1
        }
        
        x = 0
        
        for locks in boxList1 {
            
            if unlockList2[x] == 1 {
                
            }
            else {
                let lock = SKSpriteNode(imageNamed: "Lock")
                lock.size = CGSize(width: 70, height: 70)
                lock.position = CGPoint(x: 0 , y: 20)
                lock.zPosition = 111
                boxList2[x].addChild(lock)
                let monetaryValue = SKLabelNode(fontNamed: "Helvetica")
                initializeLabel(position: CGPoint(x: 0, y: -60), fontColor: coinDark, fontSize: 50, text: "100", label: monetaryValue, frame: frame1)
                monetaryValue.removeFromParent()
                monetaryValue.zPosition = 150
                boxList2[x].addChild(monetaryValue)
            }
            x += 1
        }
        
        x = 0
        
        for locks in boxList3 {
            
            if unlockList3[x] == 1 {
                
            }
            else {
                let lock = SKSpriteNode(imageNamed: "Lock")
                lock.size = CGSize(width: 70, height: 70)
                lock.position = CGPoint(x: 0 , y: 20)
                lock.zPosition = 111
                boxList3[x].addChild(lock)
                let monetaryValue = SKLabelNode(fontNamed: "Helvetica")
                initializeLabel(position: CGPoint(x: 0, y: -60), fontColor: coinDark, fontSize: 50, text: "100", label: monetaryValue, frame: frame1)
                monetaryValue.removeFromParent()
                monetaryValue.zPosition = 150
                boxList3[x].addChild(monetaryValue)
            }
            x += 1
        }
        
        x = 0
        
        for locks in boxList4 {
            
            if unlockList4[x] == 1 {
                
            }
            else {
                let lock = SKSpriteNode(imageNamed: "Lock")
                lock.size = CGSize(width: 70, height: 70)
                lock.position = CGPoint(x: 0 , y: 20)
                lock.zPosition = 111
                boxList4[x].addChild(lock)
                let monetaryValue = SKLabelNode(fontNamed: "Helvetica")
                initializeLabel(position: CGPoint(x: 0, y: -60), fontColor: coinDark, fontSize: 50, text: "100", label: monetaryValue, frame: frame1)
                monetaryValue.removeFromParent()
                monetaryValue.zPosition = 150
                boxList4[x].addChild(monetaryValue)
            }
            x += 1
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func loadValues() {
        if let x = UserDefaults.standard.object(forKey: "ClassicHighscore") as? Int{
            classicHighScore = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition1") as? Int{
            mainColor = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition2") as? Int{
            accentColor = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition3") as? Int{
            tail = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition4") as? Int{
            hat = x
        }
        
        if let x = UserDefaults.standard.object(forKey: "coins") as? Int{
            coins = x
        }
    }
    
    func findColors() {
        switch mainColor{
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
        
        switch accentColor{
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
        let happyFuschia = SKTexture(imageNamed: "FuschiaHappy")
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
    
    
    
    
    
    
    
    
    func trail(x:Int) {
        
        
        let colorSetArray:Array<Array<UIColor>> = [blueArray, yellowArray, violetArray, redArray, greenArray, fuschiaArray, orangeArray]
        
        let startPosition = ball2.position
        let endPosition = CGPoint(x: self.frame.size.width*0.95, y: self.frame.size.height*0.7)
        var triPoints = [CGPoint(x: -50,y: -50), CGPoint(x: 50, y: -50), CGPoint(x: 0, y: 50), CGPoint(x: -50, y: -50)]
        
        var marquee = SKShapeNode(circleOfRadius:50)
        var marquee2 = SKShapeNode(circleOfRadius:50)
        var marquee3 = SKShapeNode(circleOfRadius:50)

        
        switch tail {
        case 8:
            marquee = SKShapeNode(circleOfRadius:0)
            marquee.lineWidth = 25
            break
        case 9:
            marquee = SKShapeNode(circleOfRadius:50)
            marquee.lineWidth = 25
            break
        case 10:
            marquee = SKShapeNode(rectOf: CGSize(width: 100 ,height: 100), cornerRadius: 10)
            marquee.lineWidth = 25
            break
        case 11:
            marquee = SKShapeNode(points: &triPoints, count: triPoints.count)
            marquee.lineWidth = 10
            break
        case 4:
            marquee = SKShapeNode(rectOf: CGSize(width: 10 ,height: 100), cornerRadius: 10)
            marquee.lineWidth = 25
            break
        case 5:
            marquee = SKShapeNode(circleOfRadius:50)
            marquee2 = SKShapeNode(circleOfRadius:30)
            marquee3 = SKShapeNode(circleOfRadius:30)
            marquee.lineWidth = 25
            marquee2.lineWidth = 15
            marquee2.lineWidth = 15
            break
        default:
            marquee = SKShapeNode(circleOfRadius:50)
            marquee.lineWidth = 25
            break
        }
        
        
        var colorArray = blueArray
        
        switch accentColor {
        case 8:
            colorArray = blueArray
            break
        case 9:
            colorArray = yellowArray
            break
        case 10:
            colorArray = violetArray
            break
        case 11:
            colorArray = redArray
            break
        case 4:
            colorArray = greenArray
            break
        case 5:
            colorArray = fuschiaArray
            break
        case 6:
            colorArray = orangeArray
        default:
            break
            
        }
        
        marquee.strokeColor = colorArray[x]
        marquee.position = positionOfMovedTouch
        marquee2.strokeColor = colorArray[x]
        marquee2.position = positionOfMovedTouch
        marquee3.strokeColor = colorArray[x]
        marquee3.position = positionOfMovedTouch
        
        if activeFrame == frame2 {
            if tail == 5 {
                frame2.addChild(marquee)
                frame2.addChild(marquee2)
                frame2.addChild(marquee3)
            }
            else {
               frame2.addChild(marquee) 
            }
        
        }
        else if activeFrame == frame3 {
        frame3.addChild(marquee)
        }
        
        marquee.run(SKAction.repeatForever(SKAction.rotate(byAngle: 5, duration: 2)))
        marquee.run(SKAction.scale(to: 0, duration: 2))
        marquee.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeOut(withDuration: 1),
            SKAction.run {
                marquee.removeFromParent()
            }
            
            ]))
        

    }
    
    var tophatPic2 = SKSpriteNode(imageNamed: "tophat")
    var molePic2 = SKSpriteNode(imageNamed: "Wart")
    var fruitHatPic2 = SKSpriteNode(imageNamed: "fruit hat")
    var vikingHatPic2 = SKSpriteNode(imageNamed: "viking")
    var spacePic2 = SKSpriteNode(imageNamed: "spaceSuit")
    var poshPic2 = SKSpriteNode(imageNamed: "posh")
    var fishPic2 = SKSpriteNode(imageNamed: "fishbowl")
    var haloPic2 = SKSpriteNode(imageNamed: "halo")
    var strawPic2 = SKSpriteNode(imageNamed: "strawhat")
    var tiePic2 = SKSpriteNode(imageNamed: "tie")
    var plasterPic2 = SKSpriteNode(imageNamed: "plaster mask")
    
    
    func removeHat() {
        switch hat {
        case 9:
            tophatPic2.removeFromParent()
            break
        case 10:
            fruitHatPic2.removeFromParent()
            break
        case 11:
            molePic2.removeFromParent()

            break
        case 4:
            vikingHatPic2.removeFromParent()

            break
        case 5:
            spacePic2.removeFromParent()

            break
        case 6:
            poshPic2.removeFromParent()

            break
        case 7:
            fishPic2.removeFromParent()
            break
        case 0:
            haloPic2.removeFromParent()
            break
        case 1:
            strawPic2.removeFromParent()
            break
        case 2:
            tiePic2.removeFromParent()
            break
        case 3:
            plasterPic2.removeFromParent()
            break
        default:
            break
        }
        
    }
    func wearHat() {
        
        
        
        switch hat {
        case 9:
            tophatPic2.size = CGSize(width: 200, height: 200)
            tophatPic2.position.y = 120
            tophatPic2.zPosition = 50
            ball2.addChild(tophatPic2)
            break
        case 10:
            fruitHatPic2.size = CGSize(width: 200, height: 200)
            fruitHatPic2.position.y = 120
            fruitHatPic2.zPosition = 50
            ball2.addChild(fruitHatPic2)
            break
        case 11:
            molePic2.size = CGSize(width: 200, height: 200)
            molePic2.zPosition = 50
            ball2.addChild(molePic2)
            break
        case 4:
            vikingHatPic2.size = CGSize(width: 200, height: 300)
            vikingHatPic2.zPosition = 50
            ball2.addChild(vikingHatPic2)
            break
        case 5:
            spacePic2.size = CGSize(width: 200, height: 200)
            spacePic2.zPosition = 50
            ball2.addChild(spacePic2)
            break
        case 6:
            poshPic2.size = CGSize(width: 200, height: 200)
            poshPic2.zPosition = 50
            ball2.addChild(poshPic2)
            break
        case 7:
            fishPic2.size = CGSize(width: 200, height: 200)
            fishPic2.zPosition = 50
            ball2.addChild(fishPic2)
            break
        case 0:
            haloPic2.size = CGSize(width: 200, height: 200)
            haloPic2.position.y = 100
            haloPic2.zPosition = 50
            ball2.addChild(haloPic2)

            break
        case 1:
            strawPic2.size = CGSize(width: 200, height: 200)
            strawPic2.position.y = 100
            strawPic2.zPosition = 50
            ball2.addChild(strawPic2)

            break
        case 2:
            tiePic2.size = CGSize(width: 200, height: 200)
            tiePic2.position.y = -80
            tiePic2.zPosition = 50
            ball2.addChild(tiePic2)

            break
        case 3:
            plasterPic2.size = CGSize(width: 200, height: 200)
            plasterPic2.zPosition = 50
            ball2.addChild(plasterPic2)

            break
        default:
            break
        }
    }
    
    
    
    
    
    
    
}
