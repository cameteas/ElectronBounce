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
    
    
    var boxList: Array<CGPoint> = []
    var lockList1: Array<CGPoint> = []
    var lockList2: Array<CGPoint> = []
    var lockList3: Array<CGPoint> = []
    var lockList4: Array<CGPoint> = []
    
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

    
    override func didMove(to view: SKView) {
        
        if let x = UserDefaults.standard.object(forKey: "ClassicHighscore") as? Int{
            classicHighScore = x
        }
        
        
        if let x = UserDefaults.standard.object(forKey: "selectedPosition1") as? Int{
            selectedPosition1 = x
        }
        if let x = UserDefaults.standard.object(forKey: "selectedPosition2") as? Int{
            selectedPosition2 = x
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
            for box in boxList {
                createBox(Position: box, frame: frame)
            }
            createBacking(frame: frame)
            createSelected(frame: frame,box: selectedList[cycleCounter], spot: selectedvalues[cycleCounter])
            cycleCounter += 1
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
        
        
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: SKColor.cyan, fontSize: 100, text: "Accent Colour", label: tailLabel)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: SKColor.cyan, fontSize: 100, text: "Main Colour", label: themeLabel)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: SKColor.cyan, fontSize: 100, text: "Particle", label: particleLabel)
        initializeLabel(position: CGPoint(x: self.frame.size.width*0.5,y: self.frame.size.height*0.92), fontColor: blueLight, fontSize: 100, text: "Hat", label: hatLabel)
        
        frame1.addChild(tailLabel)
        frame2.addChild(themeLabel)
        frame3.addChild(particleLabel)
        frame4.addChild(hatLabel)
        
        
        
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
            for box in boxList {
                if positionOfInitialTouch.x > box.x - 70 {
                    if positionOfInitialTouch.x < box.x + 70 {
                        if positionOfInitialTouch.y > box.y - 70 {
                            if positionOfInitialTouch.y < box.y + 70 {
                                switch frameNum {
                                case 1:
                                    
                                    if lockList1[cycleCounter] == CGPoint(x: -500, y: -500){
                                        selected1.position = box
                                        selectedPosition1 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition1, forKey: "selectedPosition1")
                                    }
                                    break
                                case 2:
                                    
                                    if lockList2[cycleCounter] == CGPoint(x: -500, y: -500){
                                        selected2.position = box
                                        selectedPosition2 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition2, forKey: "selectedPosition2")
                                    }
                                    break
                                case 3:
                                    
                                    if lockList3[cycleCounter] == CGPoint(x: -500, y: -500){
                                        selected3.position = box
                                        selectedPosition3 = cycleCounter
                                        UserDefaults.standard.set(selectedPosition3, forKey: "selectedPosition3")
                                    }
                                    break
                                case 4:
                                    
                                    if lockList4[cycleCounter] == CGPoint(x: -500, y: -500){
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
    
    
    
    func unlockShit() {
        
        lockList1 = boxList
        lockList2 = boxList
        lockList3 = boxList
        lockList4 = boxList
        
        
        lockList1[8] = CGPoint(x:-500,y: -500)
        lockList2[8] = CGPoint(x:-500,y: -500)
        lockList3[8] = CGPoint(x:-500,y: -500)
        lockList4[8] = CGPoint(x:-500,y: -500)
        
        if classicHighScore > 2 {
            lockList1[9] = CGPoint(x:-500,y: -500)
            if classicHighScore > 8 {
                lockList1[10] = CGPoint(x:-500,y: -500)
                if classicHighScore > 16 {
                    lockList1[11] = CGPoint(x:-500,y: -500)
                    if classicHighScore > 24 {
                        lockList1[4] = CGPoint(x:-500,y: -500)
                    }
                }
            }
        }
        
        if classicHighScore > 4 {
            lockList2[9] = CGPoint(x:-500,y: -500)
            if classicHighScore > 12 {
                lockList2[10] = CGPoint(x:-500,y: -500)
                if classicHighScore > 18 {
                    lockList2[11] = CGPoint(x:-500,y: -500)
                    if classicHighScore > 28 {
                        lockList2[4] = CGPoint(x:-500,y: -500)
                    }
                }
            }
        }
        
        if classicHighScore > 10 {
            lockList4[9] = CGPoint(x:-500,y: -500)
            if classicHighScore > 20 {
                lockList4[10] = CGPoint(x:-500,y: -500)
                if classicHighScore > 30 {
                    lockList4[11] = CGPoint(x:-500,y: -500)
                    if classicHighScore > 50 {
                        lockList4[4] = CGPoint(x:-500,y: -500)
                    }
                }
            }
        }
        for lock in lockList1 {
            createLock(Position: lock, frame: frame1)
        }
        for lock in lockList2 {
            createLock(Position: lock, frame: frame2)
        }
        for lock in lockList3 {
            createLock(Position: lock, frame: frame3)
        }
        for lock in lockList4 {
            createLock(Position: lock, frame: frame4)
        }
    }
    
    
    
    
    
    func InitializeImages() {
        func page1() {
            blueTail.position = boxList[8]
            blueTail.size = CGSize(width: 120, height: 120)
            blueTail.zPosition = 110
            frame1.addChild(blueTail)
            if classicHighScore > 2 {
                yellowTail.position = boxList[9]
                yellowTail.size = CGSize(width: 120, height: 120)
                yellowTail.zPosition = 110
                frame1.addChild(yellowTail)
                if classicHighScore > 8 {
                    purpleTail.position = boxList[10]
                    purpleTail.size = CGSize(width: 120, height: 120)
                    purpleTail.zPosition = 110
                    frame1.addChild(purpleTail)
                    if classicHighScore > 16 {
                        redTail.position = boxList[11]
                        redTail.size = CGSize(width: 120, height: 120)
                        redTail.zPosition = 110
                        frame1.addChild(redTail)
                        if classicHighScore > 24 {
                            greenTail.position = boxList[4]
                            greenTail.size = CGSize(width: 120, height: 120)
                            greenTail.zPosition = 110
                            frame1.addChild(greenTail)
                        }
                    }
                }
            }
        }
        func page2() {
            blueCharacter.position = boxList[8]
            blueCharacter.size = CGSize(width: 120, height: 120)
            blueCharacter.zPosition = 110
            frame2.addChild(blueCharacter)
            if classicHighScore > 4 {
                yellowCharacter.position = boxList[9]
                yellowCharacter.size = CGSize(width: 120, height: 120)
                yellowCharacter.zPosition = 110
                frame2.addChild(yellowCharacter)
                if classicHighScore > 12 {
                    purpleCharacter.position = boxList[10]
                    purpleCharacter.size = CGSize(width: 120, height: 120)
                    purpleCharacter.zPosition = 110
                    frame2.addChild(purpleCharacter)
                    if classicHighScore > 18 {
                        redCharacter.position = boxList[11]
                        redCharacter.size = CGSize(width: 120, height: 120)
                        redCharacter.zPosition = 110
                        frame2.addChild(redCharacter)
                        if classicHighScore > 28 {
                            greenCharacter.position = boxList[4]
                            greenCharacter.size = CGSize(width: 120, height: 120)
                            greenCharacter.zPosition = 110
                            frame2.addChild(greenCharacter)
                        }
                    }
                }
            }
        }
        func page3() {
            blueSpray.position = boxList[8]
            blueSpray.size = CGSize(width: 120, height: 120)
            blueSpray.zPosition = 110
            frame3.addChild(blueSpray)
        }
        func page4() {
            
            if classicHighScore > 10 {
                tophatPic.position = boxList[9]
                tophatPic.size = CGSize(width: 120, height: 120)
                tophatPic.zPosition = 110
                frame4.addChild(tophatPic)
                if classicHighScore > 20 {
                    fruitHatPic.position = boxList[10]
                    fruitHatPic.size = CGSize(width: 120, height: 120)
                    fruitHatPic.zPosition = 110
                    frame4.addChild(fruitHatPic)
                    if classicHighScore > 30 {
                        molePic.position = boxList[11]
                        molePic.size = CGSize(width: 120, height: 120)
                        molePic.zPosition = 110
                        frame4.addChild(molePic)
                        if classicHighScore > 50 {
                            vikingHatPic.position = boxList[4]
                            vikingHatPic.size = CGSize(width: 81, height: 131)
                            vikingHatPic.zPosition = 110
                            frame4.addChild(vikingHatPic)
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
        var yMult: CGFloat = 0.14
        
        
        while findPoints == true{
            if yCount > 1 {
                //yMult = 0.085
            }
            if yCount > 3 {
                //yMult = 0.078
            }
            boxList.append(CGPoint(x: (self.frame.size.width*xMult)*xCount, y: (self.frame.size.height*yMult)*yCount))
            
            
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
        box.position = boxList[spot]
        box.zPosition = 101
        frame.addChild(box)
    }
    
    func createLock(Position: CGPoint,frame: SKNode) {
        let lock = SKSpriteNode(imageNamed: "Lock")
        var monetaryValue = SKLabelNode(fontNamed: "Helvetica")
        lock.size = CGSize(width: 70, height: 70)
        lock.position = CGPoint(x: Position.x , y: Position.y + 20)
        lock.zPosition = 111
        frame.addChild(lock)
        initializeLabel(position: CGPoint(x: Position.x, y: Position.y-60), fontColor: coinDark, fontSize: 50, text: "100", label: monetaryValue)
        monetaryValue.zPosition = 150
        frame.addChild(monetaryValue)
    }
    
    func returnToGame() {
        self.removeAllChildren()
        var newGame = wallJumperGame(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    
    
    
    

    
    
    
    
    
    
    
}
