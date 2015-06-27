//
//  Lattice.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 6/27/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit


// ************************************************
// A lattice of slots
// ************************************************
class Lattice : SKNode {
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Instance members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    var slots = [Slot]()
    
    let rowSizeEven = 6
    let rowSizeOdd  = 5
    let nRows: Int
    
    
    // ------------------------------------------------
    // *** Designated Initializer
    // ------------------------------------------------
    init (nRows: Int, background: GameScene) {
        
        self.nRows = nRows
        
        super.init()
        
        for row in 1...nRows{
            
            let rowIndex = CGFloat(row) - ceil(CGFloat(nRows)/2.0)
            
            if row % 2 > 0 {
                for i in 1...rowSizeOdd {
                    let columnIndex = CGFloat(i) - ceil(CGFloat(rowSizeOdd)/CGFloat(2.0))
                    
                    var newXPosition = (0.5 * background.size.width) + columnIndex * 2 * Slot.radius
                    var newYPosition = 0.5 * background.size.height + 1.5 * rowIndex * Tile.radius/CGFloat(cos30)
                    
                    var newSlot = Slot(position: CGPoint(x: newXPosition, y: newYPosition))
                    newSlot.label.text = "\(i),\(row)"
                    newSlot.indices = indexPair(x: i, y: row)
                    newSlot.state = .open
                    
                    slots.append(newSlot)
                    addChild(newSlot)
                }
            } else {
                for i in 1...rowSizeEven {
                    let columnIndex = CGFloat(i) - ceil(CGFloat(rowSizeOdd)/CGFloat(2.0))
                    
                    var newXPosition = (0.5 * background.size.width) + columnIndex * 2 * Slot.radius - Slot.radius
                    var newYPosition = 0.5 * background.size.height + 1.5 * rowIndex * Tile.radius/CGFloat(cos30)
                    
                    var newSlot = Slot(position: CGPoint(x: newXPosition, y: newYPosition))
                    newSlot.label.text = "\(i),\(row)"
                    newSlot.indices = indexPair(x: i, y: row)
                    newSlot.state = .open
                    
                    slots.append(newSlot)
                    addChild(newSlot)
                }
            }
        }
    }
    
    
    // ------------------------------------------------
    // *** get slot with index
    // ------------------------------------------------
    func getSlot(pair: indexPair) -> Slot {

        let x = pair.x
        let y = pair.y
        
        var row_factor = 0
        var i = 1
        while i < y {
            row_factor += (rowSizeEven - (i%2))
            i++
        }
        
        let array_index = row_factor + (x-1)
        let slot_found = slots[array_index]
        
        return slot_found
    }

    
    // ------------------------------------------------
    // *** Required Initializer
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}