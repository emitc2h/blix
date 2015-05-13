//
//  HexGrid.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/7/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit

class HexGrid {
    
    let node: SKNode
    let cells: Array2D<HexSlot>
    
    init(position: CGPoint, nx: Int, ny: Int, hexSize: Double, spacing: Double) {
        node = SKNode()
        cells = Array2D<HexSlot>(columns: nx+1, rows: ny+1)
        
        for i in 0...nx {
            for j in 0...ny {
                
                // Calculate hextile position
                
                var x = CGFloat(0.0)
                var y = CGFloat(Double(j)*(hexSize*1.5))
                
                if (j%2 == 0) {
                    x = CGFloat(Double(i)*(2*cos30*hexSize))
                } else {
                    x = CGFloat(Double(i)*(2*cos30*hexSize) + hexSize*cos30)
                }
                
                var hexposition = CGPoint(x:x, y:y)
                
                var hexslot = HexSlot(side: hexSize, position: hexposition, inset: spacing)
                cells[i,j] = hexslot
                node.addChild(hexslot.node)
                node.position = position
            }
        }
    }
    
}
