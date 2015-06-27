//
//  Slot.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 6/27/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit

// ************************************************
// A pair of indices characterizing the position
// on the lattice
// ************************************************
struct indexPair {
    let x: Int
    let y: Int
}

// ************************************************
// Slot status Enum
// ************************************************\
enum slotStatus {
    case invisible
    case closed
    case open
    
    mutating func next() {
        switch self {
        case invisible:
            self = closed
            
        case closed:
            self = open
            
        case open:
            self = invisible
        }
    }
    
}


// ************************************************
// Slot a resting spot for a tile
// ************************************************
class Slot : SKNode {

    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Type members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    static var radius: CGFloat = 25.0
    static var border: CGFloat = 3.0
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Instance members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    let hexagonNode: SKSpriteNode
    let label: SKLabelNode
    
    var state: slotStatus = .invisible {
        didSet {
            switch state {
            case .invisible:
                hexagonNode.alpha = 0.0
            case .closed:
                hexagonNode.alpha = 0.4
            case .open:
                hexagonNode.alpha = 0.8
            }
        }
    }
    
    var indices: indexPair
    
    // ------------------------------------------------
    // *** Designated Initializer
    // ------------------------------------------------
    init(position: CGPoint) {
        
        // Initialize nodes
        hexagonNode = SKSpriteNode(imageNamed: "hexagon_mask")
        hexagonNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        hexagonNode.colorBlendFactor = CGFloat(1.0)
        hexagonNode.color = UIColor.blackColor()
        hexagonNode.alpha = 0.0
        hexagonNode.setScale(2 * (Slot.radius - Slot.border)/hexagonNode.size.width)
        hexagonNode.name = "slot"
        
        label = SKLabelNode()
        label.color = UIColor.whiteColor()
        label.fontSize = 18
        label.name = "slot"
        
        indices = indexPair(x: 0, y: 0)
        
        super.init()
        self.position = position
        addChild(hexagonNode)
        addChild(label)
        
        
    }
   
    // ------------------------------------------------
    // *** Required Initializer
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}