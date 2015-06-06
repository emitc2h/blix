//
//  Hexagon.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/14/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit

// ************************************************
// Hexagon class:
// The basic element of the hexagon lattice
// ************************************************
class Hexagon : SKSpriteNode {
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Data members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    
    // Hexagon size
    let side: Double
    var signal: Bool = false
    var busy: Bool = false
    var signalTime : CFTimeInterval?
    var propagationDelay : Double = 0.1
    
    // Neighbour links
    var linkRightTop    : Hexagon?
    var linkRight       : Hexagon?
    var linkRightBottom : Hexagon?
    var linkLeftBottom  : Hexagon?
    var linkLeft        : Hexagon?
    var linkLeftTop     : Hexagon?
    
    var links : Array<Hexagon?>?
    
   
    
    
    // ------------------------------------------------
    // *** CONSTRUCTOR
    // ------------------------------------------------
    init(side: Double, position: CGPoint, inset: Double = 0.0) {
        
        // Apply the inset, allowing the hexagon to have
        self.side = side - inset
        
        // Initialize the SKSpriteNode
        super.init(texture: SKTexture(imageNamed: "hexagon_mask"),
                   color: UIColor.blackColor(),
                   size: CGSize(width: 2*cos30*self.side, height: 2*self.side))
        
        // Make sure the color takes over
        self.colorBlendFactor = CGFloat(1.0)
        
        // Set the anchor point in the middle of the hexagon
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        
        // Pass the position
        self.position = position
    }

    
    
    
    // ------------------------------------------------
    // *** REQUIRED CONSTRUCTOR
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    
    // ------------------------------------------------
    // *** Hexagon is touched
    // ------------------------------------------------
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.color = UIColor.yellowColor()
        self.signalTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    
    // ------------------------------------------------
    // *** Check neighours for signal
    // ------------------------------------------------
    func finalizeLinks() {
        // Fill link array
        links = [linkRightTop, linkRight, linkRightBottom, linkLeftTop, linkLeft, linkLeftBottom]
    }
    
    
    // ------------------------------------------------
    // *** Check neighours for signal
    // ------------------------------------------------
    func scanNeighbours(currentTime: CFTimeInterval) {
        
        if (self.signalTime != nil) {
            if (CFAbsoluteTimeGetCurrent() > (self.signalTime! + 10.0*self.propagationDelay)) {
                self.color = UIColor.blackColor()
                self.busy   = false
                self.signalTime = nil
            }

            else if ((CFAbsoluteTimeGetCurrent() > (self.signalTime! + self.propagationDelay)) && (self.busy == false)) {
                for link in links! {
                    if ((link != nil) && (link!.busy == false)) {
                        link!.signalTime = CFAbsoluteTimeGetCurrent()
                        link!.color = UIColor.redColor()
                    }
                }
                self.busy = true
            }
        }
        
//
//            if (currentTime > (self.signalTime! + self.propagationDelay)) {
//                self.color = UIColor.redColor()
//                self.signalTime = nil
//                self.signal = true
//            }
//        }
    }
    
    
    
    // ------------------------------------------------
    // *** update
    // ------------------------------------------------
    func update(currentTime: CFTimeInterval) {
        if (self.busy) {
            self.color = UIColor.blueColor()
        }
        self.scanNeighbours(currentTime)
    }
    
}
