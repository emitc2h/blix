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
    var tile: SKSpriteNode!
    var tileContainer: SKNode!
    var tileSuperContainer: SKNode!
    var initialTouchPosition: CGPoint!
    var currentTouchPosition: CGPoint!
    var finalTouchPosition: CGPoint!
    var tileHeight: CGFloat!
    var tileWidth: CGFloat!
    
    // --------------------------------------------
    // When you reach the view
    // --------------------------------------------
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        initBackground()
        initTile()

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
    // initialize tile
    // --------------------------------------------
    func initTile() {
        
        tile = SKSpriteNode(imageNamed: "tile")
        tile.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        tile.blendMode = .Alpha
        tileHeight = tile.size.height
        tileWidth  = tile.size.width
        
        tileContainer = SKNode()
        tileContainer.addChild(tile)
        
        tileSuperContainer = SKNode()
        tileSuperContainer.addChild(tileContainer)
        
        tileSuperContainer.position = CGPoint(x: size.width/2, y: size.height/2)
        tileContainer.position = CGPoint(x: 0.0, y: -tileHeight/2)
        tile.position = CGPoint(x: 0.0, y: tileHeight/2)
        
        addChild(tileSuperContainer)
        
    }
    
    
    // --------------------------------------------
    // detect touch
    // --------------------------------------------
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        var touch = touches.first as! UITouch
        initialTouchPosition = CGPoint(x: size.width/2, y: size.height/2) //touch.locationInNode(self)
        
    }
    
    
    // --------------------------------------------
    // follow touch
    // --------------------------------------------
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        currentTouchPosition = touch.locationInNode(self)
        
        tile.zRotation = hexagonSideToBottom(initialTouchPosition, currentTouchPosition)
        
        //let newAnchorPoint = anchorPointFromTouches(initialTouchPosition, currentTouchPosition)
        //changeAnchorkeepPosition(tile, newAnchorPoint)
        
        var y_scale = (tileHeight - (initialTouchPosition - currentTouchPosition).mag() * 2.0) / tileHeight
        
        if y_scale < -1.0 {
            y_scale = -1.0
        }
        
        tile.color = UIColor.blackColor()
        tile.colorBlendFactor = 1.0 - fabs(y_scale)
        
        tileContainer.yScale = y_scale
        
        tileSuperContainer.zRotation = -tile.zRotation
        
    }
    
    
    // --------------------------------------------
    // detect end ot touch
    // --------------------------------------------
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        finalTouchPosition = touch.locationInNode(self)
        
        tile.colorBlendFactor = 0.0
        
        tile.zRotation = 0.0
        tileContainer.zRotation = 0.0
        tileSuperContainer.zRotation = 0.0
        //changeAnchorkeepPosition(tile, CGPoint(x:0.5, y:0.5))
        
        tileContainer.yScale = 1.0
        tileContainer.xScale = 1.0
        
    }
    
    
    // --------------------------------------------
    // update function
    // --------------------------------------------
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
