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

///Ship Vector
var shipPoints:[CGPoint] = [CGPoint(x: -24, y: -16),CGPoint(x: -24, y: 16),CGPoint(x: -40, y: 32),CGPoint(x: 58.25, y: 0),CGPoint(x: -37.75, y: -32)]
var shipThrustPoints:[CGPoint] = [CGPoint(x: -24, y: -16),CGPoint(x: -24, y: 16),CGPoint(x: -40, y: 32),CGPoint(x: 58.25, y: 0),CGPoint(x: -37.75, y: -32)]

///Asteroid 1
var largeAsteroidPoints1:[CGPoint] = [CGPoint(x: 0, y: 16),CGPoint(x: 16, y: 32),CGPoint(x: 32, y: 16),CGPoint(x: 24, y: 0),CGPoint(x: 32, y: -16),CGPoint(x: 8, y: -32),CGPoint(x: -16, y: -32),CGPoint(x: -32, y: -16),CGPoint(x: -32, y: 16),CGPoint(x: -16, y: 32)]
///Asteroid 2
var largeAsteroidPoints2:[CGPoint] = [CGPoint(x: 16, y: 8),CGPoint(x: 32, y: 16),CGPoint(x: 16, y: 32),CGPoint(x: 0, y: 24),CGPoint(x: -16, y: 32),CGPoint(x: -32, y: 16),CGPoint(x: -24, y: 0),CGPoint(x: -32, y: -16),CGPoint(x: -16, y: -32),CGPoint(x: -8, y: -24),CGPoint(x: 16, y: -32),CGPoint(x: 32, y: -8)]
///Asteroid 3
var largeAsteroidPoints3:[CGPoint] = [CGPoint(x: -16, y: 0),CGPoint(x: -32, y: -8),CGPoint(x: -16, y: -32),CGPoint(x: 0, y: -8),CGPoint(x: 0, y: -32),CGPoint(x: 16, y: -32),CGPoint(x: 32, y: -8),CGPoint(x: 32, y: 8),CGPoint(x: 16, y: 32),CGPoint(x: -8, y: 32),CGPoint(x: -32, y: 8)]
///Asteroid 4
var largeAsteroidPoints4:[CGPoint] = [CGPoint(x: 8, y: 0),CGPoint(x: 32, y: 8),CGPoint(x: 32, y: 16),CGPoint(x: 8, y: 32),CGPoint(x: -16, y: 32),CGPoint(x: -8, y: 16),CGPoint(x: -32, y: 16),CGPoint(x: -32, y: -8),CGPoint(x: -16, y: -32),CGPoint(x: 8, y: -24),CGPoint(x: 16, y: -32),CGPoint(x: 32, y: -16)]


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
