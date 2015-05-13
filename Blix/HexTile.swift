//
//  HexTile.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/5/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

// Libraries
import Foundation
import SpriteKit

// ************************************************
// HexSlot : A slot for a hexagonal tile
// ************************************************
class HexTile {
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Data members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    let side: Double
    let points: UnsafeMutablePointer<CGPoint>
    let shape: SKShapeNode
    
    
    // ------------------------------------------------
    // *** CONSTRUCTOR
    // ------------------------------------------------
    init(side: Double, position: CGPoint) {
        
        // Length of the hexagon
        self.side = side
        
        println("The HexTile side is : \(self.side)")
        
        points = UnsafeMutablePointer<CGPoint>.alloc(7)
        points[0] = CGPoint(x:                0, y:                    0)
        points[1] = CGPoint(x:  self.side*cos30, y:     -self.side*sin30)
        points[2] = CGPoint(x:  self.side*cos30, y: -self.side*(1+sin30))
        points[3] = CGPoint(x:                0, y:         -2*self.side)
        points[4] = CGPoint(x: -self.side*cos30, y: -self.side*(1+sin30))
        points[5] = CGPoint(x: -self.side*cos30, y:     -self.side*sin30)
        points[6] = CGPoint(x:                0, y:                    0)
        
        // Make the SKShapeNode
        shape = SKShapeNode(points: points, count: 7)
        shape.strokeColor = UIColor.whiteColor()
        shape.lineWidth = 3.0
        shape.position = position
        shape.fillColor = UIColor.blueColor()
    }
    
    
    
    // ------------------------------------------------
    // *** REQUIRED CONSTRUCTOR
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


