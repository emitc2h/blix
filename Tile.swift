//
//  Tile.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 6/25/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit


// ************************************************
// Parity Enum
// ************************************************
enum Parity: Int {
    case even = 1
    case odd  = -1
    
    mutating func next() {
        switch self {
        case even:
            self = odd

        case odd:
            self = even
        }
    }
}

// ************************************************
// Rotation Enum
// ************************************************
enum Rotation: Int {
    case bottom      = 0
    case bottomLeft  = 1
    case topLeft     = 2
    case top         = 3
    case topRight    = 4
    case bottomRight = 5
    
    mutating func next() {
        self = Rotation(rawValue: (self.rawValue + 1) % 6)!
    }
}


// ************************************************
// Tile : An hexagonal tile
// ************************************************
class Tile : SKNode {

    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Type members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    static var radius: CGFloat = 25.0
    
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Instance members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    let scaleNode: SKNode
    let rotationNode: SKNode
    let spriteNode: SKSpriteNode
    
    var slot: Slot! {
        didSet {
            position = slot.position
        }
    }
    
    var destinationIndexPair: indexPair!
    
    //State
    var parity: Parity = .even {
        didSet {
            let newScale = CGFloat(parity.rawValue) * fabs(spriteNode.xScale)
           spriteNode.xScale = newScale
        }
    }
    var rotation: Rotation = .bottom {
        didSet {
            let angle = hexagonCornerToBottom(rotation.rawValue)
            spriteNode.zRotation = angle
        }
    }
    
    var flipped: Bool = false
    
    
    // ------------------------------------------------
    // *** Designated Initializer
    // ------------------------------------------------
    init(imageNamed: String) {
        
        // Initialize nodes
        spriteNode   = SKSpriteNode(imageNamed: imageNamed)
        rotationNode = SKNode()
        scaleNode    = SKNode()
        super.init()
        
        // Embed the nodes
        rotationNode.addChild(spriteNode)
        scaleNode.addChild(rotationNode)
        addChild(scaleNode)
        
        // spriteNode attributes
        spriteNode.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        spriteNode.blendMode = .Alpha
        spriteNode.setScale(2 * Tile.radius/spriteNode.size.width)
        spriteNode.name = "spriteNode:tile"
        
        // rotationNode attributes
        rotationNode.position = CGPoint(x: 0.0, y: spriteNode.size.width/2)
        rotationNode.name = "rotationNode:tile"
        
        // scaleNode attributes
        scaleNode.position = CGPoint(x: 0.0, y: -spriteNode.size.width/2)
        scaleNode.name = "scaleNode:tile"
        
        // positionNode attributes
        self.name = "tile"
    }

    
    // ------------------------------------------------
    // *** Required Initializer
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // ------------------------------------------------
    // *** Flip the tile
    // ------------------------------------------------
    func flip(touchPosition: CGPoint) {
        
        let side = hexagonSideFromTouches(self.position, touchPosition)
        
        destinationIndexPair = destination(slot.indices, side)
        rotationNode.zRotation = hexagonSideToBottomFromTouches(side)
        
        var y_scale = (spriteNode.size.height - (self.position - touchPosition).mag() * 2.0) / spriteNode.size.height
        
        if y_scale < -1.0 {
            y_scale = -1.0
        }
        
        spriteNode.color = UIColor.blackColor()
        spriteNode.colorBlendFactor = 1.0 - fabs(y_scale)
        
        scaleNode.yScale = y_scale
        
        if y_scale < 0.0 {
            flipped = true
        } else {
            flipped = false
        }
        
        self.zRotation = -rotationNode.zRotation
    }
    
    
    // ------------------------------------------------
    // *** execute the flip
    // ------------------------------------------------
    func executeFlip(lattice: Lattice) {
        if flipped {
            self.slot = lattice.getSlot(destinationIndexPair)
        }
        
        destinationIndexPair = self.slot.indices
        spriteNode.colorBlendFactor = 0.0
        rotationNode.zRotation = 0.0
        scaleNode.zRotation = 0.0
        self.zRotation = 0.0
        
        scaleNode.xScale = 1.0
        scaleNode.yScale = 1.0
        flipped = false
        
    }
    
}