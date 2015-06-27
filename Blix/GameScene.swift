//
//  GameScene.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/3/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import SpriteKit
import Foundation

// ********************************************
// Game Scene class
// ********************************************
class GameScene: SKScene {

    var background: SKSpriteNode!
    var currentNode: SKNode!
    var initialTouchPosition: CGPoint!
    var currentTouchPosition: CGPoint!
    var finalTouchPosition: CGPoint!
    
    // --------------------------------------------
    // When you reach the view
    // --------------------------------------------
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        initBackground()
        
        let testTile = Tile(imageNamed: "tile", position: CGPoint(x: size.width/2, y: 0.50 * size.height))
        addChild(testTile)
        
        let testTile2 = Tile(imageNamed: "tile", position: CGPoint(x: size.width/2, y: 0.70 * size.height))
        addChild(testTile2)
        
        let testTile3 = Tile(imageNamed: "tile", position: CGPoint(x: size.width/2, y: 0.30 * size.height))
        addChild(testTile3)

    }
    
    
    // --------------------------------------------
    // initialize background
    // --------------------------------------------
    func initBackground() {
        
        background = SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0,y: 0)
        background.position = CGPoint(x:0, y:0)
        addChild(background)
        
    }
    
    
    // --------------------------------------------
    // detect touch
    // --------------------------------------------
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        var touch = touches.first as! UITouch
        currentNode = self.nodeAtPoint(touch.locationInNode(self))
    }
    
    
    // --------------------------------------------
    // follow touch
    // --------------------------------------------
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        currentTouchPosition = touch.locationInNode(self)
        
        if let name = currentNode.name {
            if name == "spriteNode:tile" {
                var testTile = ((currentNode.parent!).parent!).parent as! Tile
                testTile.flip(currentTouchPosition)
                println("flipped: \(testTile.flipped)")
            }
        }
        
    }
    
    
    // --------------------------------------------
    // detect end ot touch
    // --------------------------------------------
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        finalTouchPosition = touch.locationInNode(self)
        
        if let name = currentNode.name {
            if name == "spriteNode:tile" {
                println("Touched the tile")
                
                var testTile = ((currentNode.parent!).parent!).parent as! Tile
                testTile.executeFlip()
            }
        }
        
    }
    
    
    // --------------------------------------------
    // update function
    // --------------------------------------------
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
