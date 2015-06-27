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
    var hexLattice: Lattice!
    
    // --------------------------------------------
    // When you reach the view
    // --------------------------------------------
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        initBackground()
        
        hexLattice = Lattice(nRows: 9, background: self)
        addChild(hexLattice)
        
        let testTile = Tile(imageNamed: "tile")
        testTile.slot = hexLattice.getSlot(indexPair(x:3, y:5))
        addChild(testTile)


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

        println("==========================")
        
        var touch = touches.first as! UITouch
        currentNode = self.nodeAtPoint(touch.locationInNode(self))
        if let name = currentNode.name {
            if name == "slot" {
                let slot = currentNode.parent as! Slot
                slot.state.next()
            }
        }
    }
    
    
    // --------------------------------------------
    // follow touch
    // --------------------------------------------
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        currentTouchPosition = touch.locationInNode(self)
        
        if let name = currentNode.name {
            if name == "spriteNode:tile" {
                let testTile = ((currentNode.parent!).parent!).parent as! Tile
                testTile.flip(currentTouchPosition)
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
                let testTile = ((currentNode.parent!).parent!).parent as! Tile
                testTile.executeFlip(hexLattice)
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
