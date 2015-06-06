//
//  Lattice.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/14/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit


// ************************************************
// Lattice class:
// The collection of hexagons the user sees
// ************************************************
class Lattice : SKNode {
    
    // - - - - - - - - - - - - - - - - - - - - - - - -
    // Data members
    // - - - - - - - - - - - - - - - - - - - - - - - -
    
    // The individual hexagons, stored in a 2D array
    let hexagons: Array2D<Hexagon>
    let nHexX: Int
    let nHexY: Int
    
    
    
    
    // ------------------------------------------------
    // *** CONSTRUCTOR
    // ------------------------------------------------
    init(position: CGPoint, nx: Int, ny: Int, hexSize: Double, spacing: Double) {
        
        // Initialize the 2D array
        hexagons = Array2D<Hexagon>(columns: nx+1, rows: ny+1)
        
        // Record array size
        self.nHexX = nx
        self.nHexY = ny
        
        // Initialize the SKNode
        super.init()
        
        // Create the individual hexagons
        for i in 0...nx {
            for j in 0...ny {
                
                // Calculate hexagon position
                var x = CGFloat(0.0)
                var y = CGFloat(Double(j)*(hexSize*1.5))
                
                // Displace by 1/2 a hexagon for odd rows
                if (j%2 == 0) {
                    x = CGFloat(Double(i)*(2*cos30*hexSize))
                } else {
                    x = CGFloat(Double(i)*(2*cos30*hexSize) + hexSize*cos30)
                }
                
                // Create and append the hexagons
                var hexposition = CGPoint(x:x, y:y)
                var hexagon = Hexagon(side: hexSize, position: hexposition, inset: spacing)
                
                // Enable the hexagons to react to touch
                hexagon.userInteractionEnabled = true
                
                // Register hexagon in array
                hexagons[i,j] = hexagon
                self.addChild(hexagon)
            }
        }
        
        self.position = position
        
        // Link the hexagons in the lattice
        self.linkNeighbours()
        for i in 0...nx {
            for j in 0...ny {
                hexagons[i,j]!.finalizeLinks()
            }
        }
    }
    
    
    
    
    // ------------------------------------------------
    // *** REQUIRED CONSTRUCTOR
    // ------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // ------------------------------------------------
    // *** Link neighbouring hexagons
    // ------------------------------------------------
    func linkNeighbours() {
        
        var iRightTop : Int = -1
        var jRightTop : Int = -1
        
        var iRight : Int = -1
        var jRight : Int = -1
        
        var iRightBottom : Int = -1
        var jRightBottom : Int = -1
        
        
        var iLeftTop : Int = -1
        var jLeftTop : Int = -1
        
        var iLeft : Int = -1
        var jLeft : Int = -1
        
        var iLeftBottom : Int = -1
        var jLeftBottom : Int = -1
        
        
        
        for i in 0...nHexX {
            for j in 0...nHexY {
         
                jRightTop = j-1
                jRight = j
                jRightBottom = j+1
                jLeftTop = j-1
                jLeft = j
                jLeftBottom = j+1
                
                iRight = i+1
                iLeft = i-1
                
                // Make sure indices along the x-axis take into account the odd-even half-a-hexagon shift
                if (j%2 == 0) {
                    iRightTop = i
                    iRightBottom = i
                    iLeftTop = i-1
                    iLeftBottom = i-1
                } else {
                    iRightTop = i+1
                    iRightBottom = i+1
                    iLeftTop = i
                    iLeftBottom = i
                }
                
                println("--------------------------------")
                println("i:\(i), j:\(j)")
                
                // Establish the links if the indices are valid
                if ((0 <= iRightTop)    && (iRightTop < nHexX)   && (0 <= jRightTop)     && (jRightTop < nHexY)) {
                    hexagons[i,j]!.linkRightTop = hexagons[iRightTop, jRightTop]
                    println("Connecting RightTop")
                }
                
                if ((0 <= iRight)       && (iRight < nHexX)       && (0 <= jRight)       && (jRight < nHexY)) {
                    hexagons[i,j]!.linkRight = hexagons[iRight, jRight]
                    println("Connecting Right")
                }
                
                if ((0 <= iRightBottom) && (iRightBottom < nHexX) && (0 <= jRightBottom) && (jRightBottom < nHexY)) {
                    hexagons[i,j]!.linkRightBottom = hexagons[iRightBottom, jRightBottom]
                    println("Connecting RightBottom")
                }
                
                if ((0 <= iLeftTop)    && (iLeftTop < nHexX)    && (0 <= jLeftTop)    && (jLeftTop < nHexY)) {
                    hexagons[i,j]!.linkLeftTop = hexagons[iLeftTop, jLeftTop]
                    println("Connecting LeftTop")
                }
                
                if ((0 <= iLeft)       && (iLeft < nHexX)       && (0 <= jLeft)       && (jLeft < nHexY)) {
                    hexagons[i,j]!.linkLeft = hexagons[iLeft, jLeft]
                    println("Connecting Left")
                }
                
                if ((0 <= iLeftBottom) && (iLeftBottom < nHexX) && (0 <= jLeftBottom) && (jLeftBottom < nHexY)) {
                    hexagons[i,j]!.linkLeftBottom = hexagons[iLeftBottom, jLeftBottom]
                    println("Connecting LeftBottom")
                }
                

            }
        }
    }
    
    
    
    // ------------------------------------------------
    // *** update
    // ------------------------------------------------
    func update(currentTime: CFTimeInterval) {
        for i in 0...nHexX {
            for j in 0...nHexY {
                hexagons[i,j]!.update(currentTime)
            }
        }
    }

    
}