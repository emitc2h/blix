//
//  HexSlot.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/3/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

// Libraries
import Foundation
import SpriteKit

// ************************************************
// HexSlot : A slot for a hexagonal tile
// ************************************************
class HexSlot {
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Data members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    let side:  Double
    let tex:   SKTexture
    let color: UIColor
    let node:  SKSpriteNode
    
    
    // ------------------------------------------------
    // *** CONSTRUCTOR
    // ------------------------------------------------
    init(side: Double, position: CGPoint, inset: Double) {
        
        // Length of the hexagon
        self.side = side - inset
        self.tex = SKTexture(imageNamed: "hexagon_mask")
        
        self.color = UIColor.blackColor()
        self.node = SKSpriteNode(texture: self.tex, color: self.color, size: CGSize(width: 2*cos30*self.side, height: 2*self.side))
        self.node.colorBlendFactor = CGFloat(1.0)
        self.node.position = position
    }
    
    

    // ------------------------------------------------
    // *** REQUIRED CONSTRUCTOR
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


