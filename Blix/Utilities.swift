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
func anchorPointFromTouches (initialTouch: CGPoint, finalTouch: CGPoint) -> CGPoint {
    let side = hexagonSideFromTouches (initialTouch, finalTouch)
    
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
func hexagonSideToBottom (initialTouch: CGPoint, finalTouch: CGPoint) -> CGFloat {
    
    let side = hexagonSideFromTouches (initialTouch, finalTouch)
    
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
func changeAnchorkeepPosition (node: SKSpriteNode, newAnchorPoint: CGPoint) {
    
    let dx = node.size.width * (newAnchorPoint.x - node.anchorPoint.x)
    let dy = node.size.height * (newAnchorPoint.y - node.anchorPoint.y)
    
    let delta = CGPoint(x: dx, y: dy)
    
    node.anchorPoint = newAnchorPoint
    node.position = node.position + delta
}

// --------------------------------------------------------


// --------------------------------------------------------
func rotateAboutCenter (node: SKSpriteNode, angle: CGFloat) {
    
    let currentAnchorPoint = node.anchorPoint
    let center = CGPoint(x: 0.5, y: 0.5)
}






















