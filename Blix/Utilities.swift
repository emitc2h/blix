//
//  Utilities.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/3/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import Foundation
import SpriteKit


// Constants
// --------------------------------------------------------
let cos30 = cos(M_PI/6)
let sin30 = sin(M_PI/6)


// Add 2D vectors
// --------------------------------------------------------
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}


// Subtract 2D vectors
// --------------------------------------------------------
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}


// Multiply 2D vectors by a scalar
// --------------------------------------------------------
func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}


// Divide 2D vector by a scalar
// --------------------------------------------------------
func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}


// Vector magnitude
// --------------------------------------------------------
extension CGPoint {
    func mag () -> CGFloat {
        return sqrt(self.x*self.x + self.y*self.y)
    }
}


// --------------------------------------------------------
extension CGFloat {
    func degrees_to_radians() -> CGFloat {
        return CGFloat(M_PI) * self / 180.0
    }
}


// --------------------------------------------------------
func hexagonSideFromTouches (initialTouch: CGPoint, finalTouch: CGPoint) -> Int {
    
    let vector = finalTouch - initialTouch
    return (Int(floor(atan2(vector.x, vector.y) / CGFloat(M_PI/3.0))) + 6) % 6
}


// --------------------------------------------------------
func destination(initial: indexPair, side: Int) -> indexPair {

    let correction = initial.y % 2

    switch side {
    case 0:
        return indexPair(x: initial.x + correction, y: initial.y + 1)
    case 1:
        return indexPair(x: initial.x + 1, y: initial.y)
    case 2:
        return indexPair(x: initial.x + correction, y: initial.y - 1)
    case 3:
        return indexPair(x: initial.x - 1 + correction, y: initial.y - 1)
    case 4:
        return indexPair(x: initial.x - 1, y: initial.y)
    case 5:
        return indexPair(x: initial.x - 1 + correction, y: initial.y + 1)
    default:
        return indexPair(x: initial.x, y: initial.y)
        }

}


// --------------------------------------------------------
func anchorPointFromTouches (side: Int) -> CGPoint {
    
    switch side {
    case 0:
        return CGPoint(x: 0.750, y: 0.875)
    case 1:
        return CGPoint(x: 1.000, y: 0.500)
    case 2:
        return CGPoint(x: 0.750, y: 0.125)
    case 3:
        return CGPoint(x: 0.250, y: 0.125)
    case 4:
        return CGPoint(x: 0.000, y: 0.500)
    case 5:
        return CGPoint(x: 0.250, y: 0.875)
    default:
        return CGPoint(x: 0.500, y: 0.500)
    }
}


// --------------------------------------------------------
func angleFromTouches (initialTouch: CGPoint, finalTouch: CGPoint) -> CGFloat {
    
    let vector = finalTouch - initialTouch
    let angle = atan2(vector.x, vector.y)
    return CGFloat(-angle)
}


// --------------------------------------------------------
func hexagonSideToBottomFromTouches (side: Int) -> CGFloat {
    
    switch side {
    case 5:
        return CGFloat(5  * M_PI/6)
    case 4:
        return CGFloat(3  * M_PI/6)
    case 3:
        return CGFloat(1  * M_PI/6)
    case 2:
        return CGFloat(11 * M_PI/6)
    case 1:
        return CGFloat(9  * M_PI/6)
    case 0:
        return CGFloat(7  * M_PI/6)
    default:
        return CGFloat()
    }
    
}


// --------------------------------------------------------
func hexagonSideToBottom (side: Int) -> CGFloat {
    
    switch side {
    case 5:
        return CGFloat(5  * M_PI/6)
    case 4:
        return CGFloat(3  * M_PI/6)
    case 3:
        return CGFloat(1  * M_PI/6)
    case 2:
        return CGFloat(11 * M_PI/6)
    case 1:
        return CGFloat(9  * M_PI/6)
    case 0:
        return CGFloat(7  * M_PI/6)
    default:
        return CGFloat()
    }
    
}


// --------------------------------------------------------
func hexagonCornerToBottom (side: Int) -> CGFloat {
    
    switch side {
    case 5:
        return CGFloat(5  * M_PI/3)
    case 4:
        return CGFloat(4  * M_PI/3)
    case 3:
        return CGFloat(M_PI)
    case 2:
        return CGFloat(2 * M_PI/3)
    case 1:
        return CGFloat(M_PI/3)
    case 0:
        return CGFloat(0)
    default:
        return CGFloat()
    }
    
}






















