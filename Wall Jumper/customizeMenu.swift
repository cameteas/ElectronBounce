//
//  customizeMenu.swift
//  Wall Jumper
//
//  Created by Cameron Teasdale on 2017-02-04.
//  Copyright © 2017 Cameron Teasdale. All rights reserved.
//

import Foundation
import SpriteKit

class customizeMenu: SKScene {
    
    
    /////variables/////
    
    
    // selection interface
    var selectionBox = SKSpriteNode(imageNamed: "SelectedBox")

    var boxSelected = 1
    var classicHighScore = 0
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
    
    var grayDark = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
    var grayMid = UIColor(red: 33/255, green: 33/255, blue: 34/255, alpha: 1)
    var grayMidLight = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    var grayLight = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)

    var blueLight = UIColor(red: 79/255, green: 198/255, blue: 240/255, alpha: 1)
    
    var coinDark = UIColor(red: 211/255, green: 144/255, blue: 48/255, alpha: 1)
    var coinLight = UIColor(red: 211/255, green: 163/255, blue: 194/255, alpha: 1)
    
    
    var boxPositions: Array<CGPoint> = []
    var lockList1: Array<CGPoint> = []
    var lockList2: Array<CGPoint> = []
    var lockList3: Array<CGPoint> = []
    var lockList4: Array<CGPoint> = []
    
    var itemBoxList1: Array<SKSpriteNode> = []
    var itemBoxList2: Array<SKSpriteNode> = []
    var itemBoxList3: Array<SKSpriteNode> = []
    var itemBoxList4: Array<SKSpriteNode> = []
    
    
    let selected1 = SKSpriteNode(imageNamed: "SelectedBox")
    let selected2 = SKSpriteNode(imageNamed: "SelectedBox")
    let selected3 = SKSpriteNode(imageNamed: "SelectedBox")
    let selected4 = SKSpriteNode(imageNamed: "SelectedBox")
    var selectedPosition1 = 0
    var selectedPosition2 = 0
    var selectedPosition3 = 0
    var selectedPosition4 = 0
    
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
    
    var blueSpray = SKSpriteNode(imageNamed: "BlueParticle")
    
    var tophatPic = SKSpriteNode(imageNamed: "tophat")
    var molePic = SKSpriteNode(imageNamed: "Wart")
    var fruitHatPic = SKSpriteNode(imageNamed: "fruit hat")
    var vikingHatPic = SKSpriteNode(imageNamed: "viking")
    
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
    
    
    var ball = SKSpriteNode(imageNamed: "blueNeutral")
    var tail = 0
    var hat = 0
    
    
    override func didMove(to view: SKView) {
        
        if let x = UserDefaults.standard.object(forKey: "ClassicHighscore") as? Int{
            classicHighScore = x
        }
        
        
        
        if let x = UserDefaults.standard.object(forKey: "selectedPosition1") as? Int{
            selectedPosition2 = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition2") as? Int{
            selectedPosition1 = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition3") as? Int{
            selectedPosition3 = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition4") as? Int{
            selectedPosition4 = x
        }
        
        
        findPoints()


        
        let frameList = [frame1, frame2, frame3, frame4]
        let selectedList = [selected1,selected2, selected3, selected4]
        var selectedvalues = [selectedPosition1, selectedPosition2, selectedPosition3, selectedPosition4]
        var cycleCounter = 0
        
        for frame in frameList {
            for box in boxPositions {
                createBox(Position: box, frame: frame)
            }
            createBacking(frame: frame)
            createSelected(frame: frame,box: selectedList[cycleCounter], spot: selectedvalues[cycleCounter])
            cycleCounter += 1
        }

        for box in itemBoxList1 {
            box.run(SKAction.sequence([
                SKAction.scale(to: 0, duration: 0),
                SKAction.scale(to: 0.8, duration: 0.1),
                SKAction.scale(to: 1.2, duration: 0.1),
                SKAction.scale(to: 1, duration: 0.1),
                ]))
        }
        
        self.backgroundColor = grayDark
        frame1.position = CGPoint(x:self.frame.size.width*0, y:self.frame.size.height*0)
        frame2.position = CGPoint(x:self.frame.size.width*1.5, y:self.frame.size.height*0)
        frame3.position = CGPoint(x:self.frame.size.width*1.5, y:self.frame.size.height*0)
        frame4.position = CGPoint(x:self.frame.size.width*1.5, y:self.frame.size.height*0)
        
        
        self.addChild(frame1)
        self.addChild(frame2)
        self.addChild(frame3)
        self.addChild(frame4)
        InitializeImages()
        unlockShit()
        
        page1Display.fillColor = SKColor.cyan
        page1Display.position = CGPoint(x: self.frame.size.width*0.41, y: self.frame.size.height*0.04)
        page1Display.strokeColor = SKColor.black
        self.addChild(page1Display)
        page2Display.fillColor = SKColor.gray
        page2Display.position = CGPoint(x: self.frame.size.width*0.47, y: self.frame.size.height*0.04)
        page2Display.strokeColor = SKColor.black
        self.addChild(page2Display)
        page3Display.fillColor = SKColor.gray
        page3Display.position = CGPoint(x: self.frame.size.width*0.53, y: self.frame.size.height*0.04)
        page3Display.strokeColor = SKColor.black
        self.addChild(page3Display)
        page4Display.fillColor = SKColor.gray
        page4Display.position = CGPoint(x: self.frame.size.width*0.59, y: self.frame.size.height*0.04)
        page4Display.strokeColor = SKColor.black
        self.addChild(page4Display)
        
        
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: SKColor.cyan, fontSize: 70, text: "Accent Colour", label: tailLabel)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: SKColor.cyan, fontSize: 70, text: "Main Colour", label: themeLabel)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: SKColor.cyan, fontSize: 100, text: "Particle", label: particleLabel)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: blueLight, fontSize: 100, text: "Hat", label: hatLabel)
        
        frame1.addChild(tailLabel)
        frame2.addChild(themeLabel)
        frame3.addChild(particleLabel)
        frame4.addChild(hatLabel)
        
        
        ball.position = CGPoint(x:self.frame.size.width*0.3, y: self.frame.size.height*0.7)
        ball.size = CGSize(width: 100, height: 100)
        self.addChild(ball)
        drawMarquee()
        
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfInitialTouch = touch.location(in: self)
            
            
            if positionOfInitialTouch.y > self.frame.size.height*0.9 {
                returnToGame()
                            }
            
           
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            positionOfMovedTouchSaved = positionOfMovedTouch
            positionOfMovedTouch = touch.location(in: self)
            
            if firsTouch {
                firsTouch = false
            }
            else{
                touchMovedSwipe()
            }
            
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        firsTouch = true
        touchEndedSwipe()
        if isSwiped == false {
            var cycleCounter = 0
            for box in boxPositions {
                if positionOfInitialTouch.x > box.x - 70 {
                    if positionOfInitialTouch.x < box.x + 70 {
                        if positionOfInitialTouch.y > box.y - 70 {
                            if positionOfInitialTouch.y < box.y + 70 {
                                switch frameNum {
                                case 1:
                                    
                                    if lockList1[cycleCounter] == CGPoint(x: -20000, y: -20000){
                                        selected1.position = CGPoint(x: 0, y: 0)
                                        selected1.removeFromParent()
                                        itemBoxList1[cycleCounter].addChild(selected1)
                                        selectedPosition1 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition1, forKey: "selectedPosition1")
                                    }
                                    break
                                case 2:
                                    
                                    if lockList2[cycleCounter] == CGPoint(x: -20000, y: -20000){
                                        selected2.position = box
                                        selectedPosition2 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition2, forKey: "selectedPosition2")
                                    }
                                    break
                                case 3:
                                    
                                    if lockList3[cycleCounter] == CGPoint(x: -20000, y: -20000){
                                        selected3.position = box
                                        selectedPosition3 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition3, forKey: "selectedPosition3")
                                    }
                                    break
                                case 4:
                                    
                                    if lockList4[cycleCounter] == CGPoint(x: -20000, y: -20000){
                                        selected4.position = box
                                        selectedPosition4 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition4, forKey: "selectedPosition4")
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
        
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //////////////////////////////
    //////////////////////////////
    /////essential Functions///////
    //////////////////////////////
    //////////////////////////////
    
    
    let lockHide = CGPoint(x: -20000, y: -20000)
    
    func unlockShit() {
        
        lockList1 = boxPositions
        lockList2 = boxPositions
        lockList3 = boxPositions
        lockList4 = boxPositions
        
        
        lockList1[8] = lockHide
        lockList2[8] = lockHide
        lockList3[8] = lockHide
        lockList4[8] = lockHide
        
        if classicHighScore > 2 {
            lockList1[9] = lockHide
            if classicHighScore > 8 {
                lockList1[10] = lockHide
                if classicHighScore > 16 {
                    lockList1[11] = lockHide
                    if classicHighScore > 24 {
                        lockList1[4] = lockHide
                    }
                }
            }
        }
        
        if classicHighScore > 4 {
            lockList2[9] = lockHide
            if classicHighScore > 12 {
                lockList2[10] = lockHide
                if classicHighScore > 18 {
                    lockList2[11] = lockHide
                    if classicHighScore > 28 {
                        lockList2[4] = lockHide
                    }
                }
            }
        }
        
        if classicHighScore > 10 {
            lockList4[9] = lockHide
            if classicHighScore > 20 {
                lockList4[10] = lockHide
                if classicHighScore > 30 {
                    lockList4[11] = lockHide
                    if classicHighScore > 40 {
                        lockList4[4] = lockHide
                    }
                }
            }
        }
        var lockCount = 0
        for lock in lockList1 {
            if lock == CGPoint(x: -20000, y: -20000) {
                createLock(Position: lock, frame: frame1, parent: itemBoxList1, parentIndex: lockCount)
                lockCount += 1
            }
            else {
                createLock(Position: CGPoint(x:0 ,y:0), frame: frame1, parent: itemBoxList1, parentIndex: lockCount)
                lockCount += 1
            }
            
        }
        lockCount = 0
        for lock in lockList2 {
            if lock == CGPoint(x: -20000, y: -20000) {
                createLock(Position: lock, frame: frame2, parent: itemBoxList2, parentIndex: lockCount)
                lockCount += 1
            }
            else {
                createLock(Position: CGPoint(x:0 ,y:0), frame: frame2, parent: itemBoxList2, parentIndex: lockCount)
                lockCount += 1
            }
        }
        lockCount = 0
        for lock in lockList3 {
            if lock == CGPoint(x: -20000, y: -20000) {
                createLock(Position: lock, frame: frame3, parent: itemBoxList3, parentIndex: lockCount)
                lockCount += 1
            }
            else {
                createLock(Position: CGPoint(x:0 ,y:0), frame: frame3, parent: itemBoxList3, parentIndex: lockCount)
                lockCount += 1
            }
        }
        lockCount = 0
        for lock in lockList4 {
            if lock == CGPoint(x: -20000, y: -20000) {
                createLock(Position: lock, frame: frame4, parent: itemBoxList4, parentIndex: lockCount)
                lockCount += 1
            }
            else {
                createLock(Position: CGPoint(x:0 ,y:0), frame: frame4, parent: itemBoxList4, parentIndex: lockCount)
                lockCount += 1
            }
        }
    }
    
    
    
    
    
    func InitializeImages() {
        
        func page1() {
            blueTail.size = CGSize(width: 120, height: 120)
            blueTail.zPosition = 110
            itemBoxList1[8].addChild(blueTail)
            if classicHighScore > 2 {
                yellowTail.size = CGSize(width: 120, height: 120)
                yellowTail.zPosition = 110
                itemBoxList1[9].addChild(yellowTail)
                if classicHighScore > 8 {
                    purpleTail.size = CGSize(width: 120, height: 120)
                    purpleTail.zPosition = 110
                    itemBoxList1[10].addChild(purpleTail)
                    if classicHighScore > 16 {
                        redTail.size = CGSize(width: 120, height: 120)
                        redTail.zPosition = 110
                        itemBoxList1[11].addChild(redTail)
                        if classicHighScore > 24 {
                            greenTail.size = CGSize(width: 120, height: 120)
                            greenTail.zPosition = 110
                            itemBoxList1[4].addChild(greenTail)
                        }
                    }
                }
            }
        }
        func page2() {
            blueCharacter.size = CGSize(width: 120, height: 120)
            blueCharacter.zPosition = 110
            itemBoxList2[8].addChild(blueCharacter)
            if classicHighScore > 4 {
                yellowCharacter.size = CGSize(width: 120, height: 120)
                yellowCharacter.zPosition = 110
                itemBoxList2[9].addChild(yellowCharacter)
                if classicHighScore > 12 {
                    purpleCharacter.size = CGSize(width: 120, height: 120)
                    purpleCharacter.zPosition = 110
                    itemBoxList2[10].addChild(purpleCharacter)
                    if classicHighScore > 18 {
                        redCharacter.size = CGSize(width: 120, height: 120)
                        redCharacter.zPosition = 110
                        itemBoxList2[11].addChild(redCharacter)
                        if classicHighScore > 28 {
                            greenCharacter.size = CGSize(width: 120, height: 120)
                            greenCharacter.zPosition = 110
                            itemBoxList2[4].addChild(greenCharacter)
                        }
                    }
                }
            }
        }
        func page3() {
            blueSpray.position = boxPositions[8]
            blueSpray.size = CGSize(width: 120, height: 120)
            blueSpray.zPosition = 110
            frame3.addChild(blueSpray)
        }
        func page4() {
            
            if classicHighScore > 10 {
                tophatPic.size = CGSize(width: 120, height: 120)
                tophatPic.zPosition = 110
                itemBoxList4[9].addChild(tophatPic)
                if classicHighScore > 20 {
                    fruitHatPic.size = CGSize(width: 120, height: 120)
                    fruitHatPic.zPosition = 110
                    itemBoxList4[10].addChild(fruitHatPic)
                    if classicHighScore > 30 {
                        molePic.size = CGSize(width: 120, height: 120)
                        molePic.zPosition = 110
                        itemBoxList4[11].addChild(molePic)
                        if classicHighScore > 40 {
                            vikingHatPic.size = CGSize(width: 81, height: 131)
                            vikingHatPic.zPosition = 110
                            itemBoxList4[4].addChild(vikingHatPic)
                        }
                    }
                }
            }
            
            
            
            
            
            
            
        }

    
        
        
        
        
        
        page1()
        page2()
        page3()
        page4()
        
    }
    
    func drawMarquee() {
        var mar1 = SKShapeNode(circleOfRadius: 35)
        
        mar1.position = CGPoint(x: ball.position.x + 30, y: ball.position.y)
        mar1.strokeColor = blueBright
        mar1.lineWidth = 20
        mar1.fillColor = SKColor.clear
        self.addChild(mar1)
    }
    
    
    


    //////////////////////////////
    //////////////////////////////
    /////Cleaning Up Functions////
    //////////////////////////////
    //////////////////////////////

    
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
                page1Display.fillColor = SKColor.gray
                page2Display.fillColor = SKColor.cyan
                page3Display.fillColor = SKColor.gray
                page4Display.fillColor = SKColor.gray
                page1Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page2Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: itemBoxList2)
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
                page1Display.fillColor = SKColor.cyan
                page2Display.fillColor = SKColor.gray
                page3Display.fillColor = SKColor.gray
                page4Display.fillColor = SKColor.gray
                page2Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page1Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: itemBoxList1)
                
                
            }
            else if frame2.position.x < self.frame.size.width*(-0.1){
                frame2.run(SKAction.move(to: CGPoint(x: self.frame.size.width*(-1.5), y: self.frame.size.height*0), duration: 0.1))
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 3
                page1Display.fillColor = SKColor.gray
                page2Display.fillColor = SKColor.gray
                page3Display.fillColor = SKColor.cyan
                page4Display.fillColor = SKColor.gray
                page2Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page3Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: itemBoxList3)
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
                page1Display.fillColor = SKColor.gray
                page2Display.fillColor = SKColor.cyan
                page3Display.fillColor = SKColor.gray
                page4Display.fillColor = SKColor.gray
                page3Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page2Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: itemBoxList2)
                
            }
            else if frame3.position.x < self.frame.size.width*(-0.1){
                frame3.run(SKAction.move(to: CGPoint(x: self.frame.size.width*(-1.5), y: self.frame.size.height*0), duration: 0.1))
                frame4.run(SKAction.move(to: CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0), duration: 0.1))
                frameNum = 4
                page1Display.fillColor = SKColor.gray
                page2Display.fillColor = SKColor.gray
                page3Display.fillColor = SKColor.gray
                page4Display.fillColor = SKColor.cyan
                page3Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page4Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: itemBoxList4)
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
                page1Display.fillColor = SKColor.gray
                page2Display.fillColor = SKColor.gray
                page3Display.fillColor = SKColor.cyan
                page4Display.fillColor = SKColor.gray
                page4Display.run(SKAction.scale(by: 0.5, duration: 0.2))
                page3Display.run(SKAction.scale(by: 2, duration: 0.2))
                isSwiped = true
                wiggle(itemBoxlist: itemBoxList3)
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
            boxPositions.append(CGPoint(x: (self.frame.size.width*xMult)*xCount, y: (self.frame.size.height*yMult)*yCount))
            
            
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
        Backbox.zPosition = 100
        frame.addChild(Backbox)
        switch frame {
            case frame1:
                itemBoxList1.append(Backbox)
                break
            case frame2:
                itemBoxList2.append(Backbox)
                break
            case frame3:
                itemBoxList3.append(Backbox)
                break
            case frame4:
                itemBoxList4.append(Backbox)
                break
            default:
                break
        }
        
    }
    
    func createBacking(frame: SKNode) {
        let frameBackingTop = SKShapeNode(rectOf: CGSize(width: self.frame.size.width, height: self.frame.size.height*0.125), cornerRadius: 10)
        frameBackingTop.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.945)
        frameBackingTop.fillColor = grayMid
        frameBackingTop.lineWidth = 0
        frame.addChild(frameBackingTop)
        
        let frameBackingBottom = SKShapeNode(rectOf: CGSize(width: self.frame.size.width, height: self.frame.size.height*0.52), cornerRadius: 10)
        frameBackingBottom.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*0.24)
        frameBackingBottom.fillColor = grayMid
        frameBackingBottom.lineWidth = 0
        frame.addChild(frameBackingBottom)
    }
    
    
    func initializeLabel(position: CGPoint, fontColor: SKColor, fontSize: CGFloat, text: String, label: SKLabelNode) {
        label.position = position
        label.fontColor = fontColor
        label.fontSize = fontSize
        label.text = text
        label.zPosition = 100
    }
    
    func createSelected(frame: SKNode, box: SKSpriteNode, spot: Int) {
        box.size = CGSize(width: 140, height: 140)
        box.position = boxPositions[spot]
        box.zPosition = 101
        frame.addChild(box)
    }
    
    func createLock(Position: CGPoint,frame: SKNode, parent: Array<SKSpriteNode>, parentIndex: Int) {
        let lock = SKSpriteNode(imageNamed: "Lock")
        let monetaryValue = SKLabelNode(fontNamed: "Helvetica")
        lock.size = CGSize(width: 70, height: 70)
        lock.position = CGPoint(x: Position.x , y: Position.y + 20)
        lock.zPosition = 111
        parent[parentIndex].addChild(lock)
        initializeLabel(position: CGPoint(x: Position.x, y: Position.y-60), fontColor: coinDark, fontSize: 50, text: "100", label: monetaryValue)
        monetaryValue.zPosition = 150
        parent[parentIndex].addChild(monetaryValue)
    }
    
    var variance:CGFloat = 0
    
    func wiggle(itemBoxlist: Array<SKSpriteNode>) {
        for box in itemBoxlist {
            //variance += 0.05
            
            if variance == 0.15 {
                variance = 0
            }
            
            box.run(SKAction.sequence([
                SKAction.rotate(toAngle: 0.3 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.3 - variance, duration: 0.1),
                SKAction.rotate(toAngle: 0.25 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.25 - variance, duration: 0.1),
                SKAction.rotate(toAngle: 0.2 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.2 - variance, duration: 0.1),
                SKAction.rotate(toAngle: 0.15 + variance, duration: 0.1),
                SKAction.rotate(toAngle: -0.15 - variance, duration: 0.1),
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
    
    func returnToGame() {
        frame1.run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
            ]))
        frame1.run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 0, duration: 0.1)
            ]))
        self.removeAllChildren()
        let newGame = wallJumperGame(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
        
    }
    
    func switchColor() {
        
    }
    
    
    
    

    
    
    
    
    
    
    
}
