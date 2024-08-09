//
//  VectorGraphics.swift
//  Asteroids
//
//  Created by Jonathan French on 5.08.24.
//

import Foundation
import SwiftUI

let asteroidSize = 1.0
let shipSize = 4.0
let UFOSize = 2.0
let smallUFOSize = 3.0

///Ship Vector
var shipPoints:[CGPoint] = [CGPoint(x: -24, y: -16),CGPoint(x: -24, y: 16),CGPoint(x: -40, y: 32),CGPoint(x: 56, y: 0),CGPoint(x: -40, y: -32)]
var shipThrustPoints:[CGPoint] = [CGPoint(x: -24, y: -16),CGPoint(x: -56, y: 0),CGPoint(x: -24, y: 16)]
var shipPartA:[CGPoint] = [CGPoint(x: -40, y: -32),CGPoint(x: -24, y: -16),CGPoint(x: -24, y: 16),CGPoint(x: -40, y: 32)]
var shipPartB:[CGPoint] = [CGPoint(x: -40, y: 32),CGPoint(x: 56, y: 0)]
var shipPartC:[CGPoint] = [CGPoint(x: -40, y: -32),CGPoint(x: 56, y: 0)]

///Asteroid 1
var largeAsteroidPoints1:[CGPoint] = [CGPoint(x: 0, y: 16),CGPoint(x: 16, y: 32),CGPoint(x: 32, y: 16),CGPoint(x: 24, y: 0),CGPoint(x: 32, y: -16),CGPoint(x: 8, y: -32),CGPoint(x: -16, y: -32),CGPoint(x: -32, y: -16),CGPoint(x: -32, y: 16),CGPoint(x: -16, y: 32)]
///Asteroid 2
var largeAsteroidPoints2:[CGPoint] = [CGPoint(x: 16, y: 8),CGPoint(x: 32, y: 16),CGPoint(x: 16, y: 32),CGPoint(x: 0, y: 24),CGPoint(x: -16, y: 32),CGPoint(x: -32, y: 16),CGPoint(x: -24, y: 0),CGPoint(x: -32, y: -16),CGPoint(x: -16, y: -32),CGPoint(x: -8, y: -24),CGPoint(x: 16, y: -32),CGPoint(x: 32, y: -8)]
///Asteroid 3
var largeAsteroidPoints3:[CGPoint] = [CGPoint(x: -16, y: 0),CGPoint(x: -32, y: -8),CGPoint(x: -16, y: -32),CGPoint(x: 0, y: -8),CGPoint(x: 0, y: -32),CGPoint(x: 16, y: -32),CGPoint(x: 32, y: -8),CGPoint(x: 32, y: 8),CGPoint(x: 16, y: 32),CGPoint(x: -8, y: 32),CGPoint(x: -32, y: 8)]
///Asteroid 4
var largeAsteroidPoints4:[CGPoint] = [CGPoint(x: 8, y: 0),CGPoint(x: 32, y: 8),CGPoint(x: 32, y: 16),CGPoint(x: 8, y: 32),CGPoint(x: -16, y: 32),CGPoint(x: -8, y: 16),CGPoint(x: -32, y: 16),CGPoint(x: -32, y: -8),CGPoint(x: -16, y: -32),CGPoint(x: 8, y: -24),CGPoint(x: 16, y: -32),CGPoint(x: 32, y: -16)]

///Explosion 1
var explosionPoints1:[CGPoint] = [CGPoint(x: -16, y: 0),CGPoint(x: -16, y: -16),CGPoint(x: 16, y: -16),CGPoint(x: 24, y: 8),CGPoint(x: 16, y: -8),CGPoint(x: 0, y: 16),CGPoint(x: 8, y: 24),CGPoint(x: -8, y: 24),CGPoint(x: -32, y: -8),CGPoint(x: -24, y: 8)]
///Explosion 2
var explosionPoints2:[CGPoint] = [CGPoint(x: -14, y: 0),CGPoint(x: -14, y: -14),CGPoint(x: 14, y: -14),CGPoint(x: 21, y: 7),CGPoint(x: 14, y: -7),CGPoint(x: 0, y: 14),CGPoint(x: 7, y: 21),CGPoint(x: -7, y: 21),CGPoint(x: -28, y: -7),CGPoint(x: -21, y: 7)]
///Explosion 3
var explosionPoints3:[CGPoint] = [CGPoint(x: -12, y: 0),CGPoint(x: -12, y: -12),CGPoint(x: 12, y: -12),CGPoint(x: 18, y: 6),CGPoint(x: 12, y: -6),CGPoint(x: 0, y: 12),CGPoint(x: 6, y: 18),CGPoint(x: -6, y: 18),CGPoint(x: -24, y: -6),CGPoint(x: -18, y: 6)]
///Explosion 4
var explosionPoints4:[CGPoint] = [CGPoint(x: -10, y: 0),CGPoint(x: -10, y: -10),CGPoint(x: 10, y: -10),CGPoint(x: 15, y: 5),CGPoint(x: 10, y: -5),CGPoint(x: 0, y: 10),CGPoint(x: 5, y: 15),CGPoint(x: -5, y: 15),CGPoint(x: -20, y: -5),CGPoint(x: -15, y: 5)]

///UFO
var UFOPoints:[CGPoint] = [CGPoint(x: -16, y: 8),CGPoint(x: 16, y: 8),CGPoint(x: 40, y: -8),CGPoint(x: -40, y: -8),CGPoint(x: -16, y: -24),CGPoint(x: 16, y: -24),CGPoint(x: 40, y: -8),CGPoint(x: 16, y: 8),CGPoint(x: 8, y: 24),CGPoint(x: -8, y: 24),CGPoint(x: -16, y: 8),CGPoint(x: -40, y: -8)]

/// Draw the shape
struct VectorShape: Shape {
    var points: [CGPoint]
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if let firstPoint = points.first {
            path.move(to: firstPoint)
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
        return path
    }
}

/// Draw the line
struct VectorLine: Shape {
    var points: [CGPoint]
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if let firstPoint = points.first {
            path.move(to: firstPoint)
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
        }
        return path
    }
}
/// Rotate the shape
func rotatePoints(_ points: [CGPoint], byDegrees angle: CGFloat) -> [CGPoint] {
    let radians = angle * .pi / 180 // Convert angle to radians
    let cosAngle = cos(radians)
    let sinAngle = sin(radians)
    
    return points.map { point in
        let newX = point.x * cosAngle - point.y * sinAngle
        let newY = point.x * sinAngle + point.y * cosAngle
        return CGPoint(x: newX, y: newY)
    }
}

func isPointWithinCircle(center: CGPoint, diameter: CGFloat, point: CGPoint) -> Bool {
     let radius = diameter / 2
     let distanceX = point.x - center.x
     let distanceY = point.y - center.y
     let distanceSquared = distanceX * distanceX + distanceY * distanceY
     let radiusSquared = radius * radius
     return distanceSquared <= radiusSquared
 }

func circlesIntersect(center1: CGPoint, diameter1: CGFloat, center2: CGPoint, diameter2: CGFloat) -> Bool {
    let radius1 = diameter1 / 2
    let radius2 = diameter2 / 2

    let distanceX = center2.x - center1.x
    let distanceY = center2.y - center1.y
    let distanceSquared = distanceX * distanceX + distanceY * distanceY
    let radiusSum = radius1 + radius2
    let radiusSumSquared = radiusSum * radiusSum

    return distanceSquared <= radiusSumSquared
}

func adjustAngle(initialAngle: CGFloat, adjustment: CGFloat, add: Bool = true) -> CGFloat {
    var newAngle = add ? initialAngle + adjustment : initialAngle - adjustment
    
    // Normalize the angle to be within 0 to 360 degrees
    newAngle = newAngle.truncatingRemainder(dividingBy: 360)
    if newAngle < 0 {
        newAngle += 360
    }
    return newAngle
}

func angleBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let deltaY = point2.y - point1.y
    let deltaX = point2.x - point1.x
    let angleInRadians = atan2(deltaY, deltaX)
    let angleInDegrees = angleInRadians * 180 / .pi
    return angleInDegrees
}

/// Function to modify the angle based on an accuracy percentage
func modifiedAngleBetweenPoints(point1: CGPoint, point2: CGPoint, accuracy: CGFloat) -> CGFloat {
    let actualAngle = angleBetweenPoints(point1: point1, point2: point2)
    
    /// Calculate how much to modify the angle based on accuracy
    /// accuracy = 100 -> No modification (100% accurate)
    /// accuracy < 100 -> Modify the angle
    let modificationRange: CGFloat = 50 // Define how much the angle can be modified (e.g., ±10 degrees)
    let accuracyFactor = (100 - accuracy) / 100 // Lower accuracy means higher modification
    let modification = modificationRange * accuracyFactor
    
    /// Apply modification to the actual angle
    /// This could be a random offset within the modification range or a systematic one
    let modifiedAngle = actualAngle + (CGFloat.random(in: -modification...modification))
    
    return modifiedAngle
}

