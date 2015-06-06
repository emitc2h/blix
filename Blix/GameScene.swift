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
    
    var lattice: Lattice
    var center: CGPoint
    var tileCenter: CGPoint
    var h: CGFloat
    var w: CGFloat
    
    // --------------------------------------------
    // Constructors
    // --------------------------------------------
    override init(size: CGSize) {
        
        // Record scene size
        w = size.width
        h = size.height
        
        center = CGPoint(x: w/2, y: h/2 + 90)
        tileCenter = CGPoint(x: w/2, y: h/2 + 22.5)
        
        lattice = Lattice(position: CGPoint(x:0,y:0), nx: 19, ny: 34, hexSize: 10, spacing: 1)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // --------------------------------------------
    // When you reach the view
    // --------------------------------------------
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Set background
        //let background = SKSpriteNode(imageNamed: "background")
        //background.position = CGPoint(x: 0, y: 0)
        //background.anchorPoint = CGPoint(x: 0, y: 0)
        //addChild(background)
        backgroundColor = UIColor.whiteColor()
        
        addChild(lattice)
        
        
        //
    }
    
    
    // --------------------------------------------
    // detect touch
    // --------------------------------------------
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        // turn hexagons blue
        var touch = touches.first as! UITouch
        let positionInScene = touch.locationInNode(self)
    }
    
    
    // --------------------------------------------
    // follow touch
    // --------------------------------------------
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    
    // --------------------------------------------
    // detect end ot touch
    // --------------------------------------------
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    
    // --------------------------------------------
    // update function
    // --------------------------------------------
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.lattice.update(currentTime)
    }
}
