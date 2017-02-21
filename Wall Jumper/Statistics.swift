//
//  Statistics.swift
//  Wall Jumper
//
//  Created by Cameron Teasdale on 2017-02-16.
//  Copyright © 2017 Cameron Teasdale. All rights reserved.
//

import Foundation
import SpriteKit

class Statistics: SKScene {
    
    var shapetestNode = SKShapeNode(circleOfRadius: 40)
    var scrollBar = SKShapeNode(rectOf: CGSize(width: 50, height: 600), cornerRadius: 20)
    var backNode = SKNode()
    var firstTouch = true
    var positionOfInitialTouch = CGPoint(x: 0, y: 0)
    var positionOfMovedTouch = CGPoint(x: 0, y: 0)
    var positionOfMovedTouchsave = CGPoint(x: 0, y: 0)

    var positionOfEndedTouch = CGPoint(x: 0, y: 0)
    var backvelocity:CGFloat = 0
    var timer = Timer()
    
    override func didMove(to view: SKView) {
        
        backNode.position = CGPoint(x:self.frame.size.width*0.5, y: self.frame.size.height*0.5)
        self.addChild(backNode)
        backNode.addChild(shapetestNode)
        
        scrollBar.position = CGPoint(x: self.frame.size.width*0.97, y: self.frame.size.height*0.5)
        self.addChild(scrollBar)
        
        backNode.physicsBody = SKPhysicsBody()
        backNode.physicsBody?.affectedByGravity = false
        backNode.physicsBody?.linearDamping = 4
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfInitialTouch = touch.location(in: self)
            if positionOfInitialTouch.y > self.frame.size.height*0.9 {
                returnToGame()
            }
            backvelocity = 0
            backNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            positionOfMovedTouchsave.y = 0
            positionOfMovedTouch.y = 0
            
            
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfMovedTouchsave = positionOfMovedTouch
            positionOfMovedTouch = touch.location(in: self)
            
            if firstTouch {
                firstTouch = false
            }
            else {
                backNode.position = CGPoint(x:self.frame.size.width*0.5, y:backNode.position.y + (positionOfMovedTouch.y - positionOfMovedTouchsave.y))
            }
            
            
            
            
            
            
            
            
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            positionOfEndedTouch = touch.location(in: self)
            
            firstTouch = true
            backNode.physicsBody?.velocity = CGVector(dx:0 ,dy:(positionOfMovedTouch.y - positionOfMovedTouchsave.y)*5)
            
            
            
            
        }
    }
    
    func slide() {
        
    }
    
    func returnToGame() {
        self.removeAllChildren()
        let newGame = wallJumperGame(size: self.size)
        newGame.scaleMode = scaleMode
        self.view?.presentScene(newGame)
    }
    
    
}
