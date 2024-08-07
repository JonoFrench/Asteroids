//
//  AsteroidView.swift
//  Asteroids
//
//  Created by Jonathan French on 5.08.24.
//

import SwiftUI

let sizedAsteroidPoints1:[CGPoint] = largeAsteroidPoints1.map { point in
    CGPoint(x: point.x / asteroidSize, y: point.y / asteroidSize)
}

let sizedAsteroidPoints2:[CGPoint] = largeAsteroidPoints2.map { point in
    CGPoint(x: point.x / asteroidSize, y: point.y / asteroidSize)
}

let sizedAsteroidPoints3:[CGPoint] = largeAsteroidPoints3.map { point in
    CGPoint(x: point.x / asteroidSize, y: point.y / asteroidSize)
}

let sizedAsteroidPoints4:[CGPoint] = largeAsteroidPoints4.map { point in
    CGPoint(x: point.x / asteroidSize, y: point.y / asteroidSize)
}


struct AsteroidView: View {
    @EnvironmentObject var manager: GameManager
    var asteroid:Asteroid
    var body: some View {
        let rotatedPoints = rotatePoints(asteroid.points, byDegrees: asteroid.rotation)
        ZStack {
            VectorShape(points: rotatedPoints)
                .fill(.black)
                .stroke(.white,lineWidth: 1.0)
                .frame(width: 1,height: 1,alignment: .center)
                .background(.green)
            ///Draw a circle to determine the hit size of the asteroid
//            Circle()
//            .fill(.blue)
//            .frame(width: asteroid.asteroidType.hitSize(), height: asteroid.asteroidType.hitSize())
        }.background(.black)
    }
}

struct Asteroid:Identifiable {
    var id = UUID()
    var position = CGPoint(x: 0, y: 0)
    var angle = 0.0
    var rotation = 180.0
    var velocity = 10.0
    var asteroidType:AsteroidType = .large
    var asteroidShape:AsteroidShape = .ShapeA
    var points:[CGPoint]

    init(position: CGPoint, angle: Double = 0.0, rotation: Double = 180.0, velocity: Double = 10.0, type: AsteroidType, shape: AsteroidShape) {
        self.position = position
        self.angle = angle
        self.rotation = rotation
        self.velocity = velocity
        self.asteroidType = type
        self.asteroidShape = shape
        self.points = asteroidType.shape(points:asteroidShape.points())
    }
    
    func checkHit(bulletPos:CGPoint) -> Bool {
        let aSize = asteroidType.hitSize()
        
        if bulletPos.x > position.x - aSize && bulletPos.x < position.x + aSize {
            ///Hit on the X
            if bulletPos.y > position.y - aSize && bulletPos.y < position.y + aSize {
            /// Hit on the X & Y
                print("Hit!!!!")
                return true
            }
        }
        
        return false
    }
    
}

enum AsteroidShape {
    case ShapeA,ShapeB,ShapeC, ShapeD
    
    func points() -> [CGPoint] {
        switch self {
        case .ShapeA:
            return largeAsteroidPoints1
        case .ShapeB:
            return largeAsteroidPoints2
        case .ShapeC:
            return largeAsteroidPoints3
        case .ShapeD:
            return largeAsteroidPoints4
        }
    }
}

enum AsteroidType {
    case large,medium,small
    
    func shape(points: [CGPoint]) -> [CGPoint] {
        switch self {
        case .large:
            return points.map { point in
                CGPoint(x: point.x / 1.0, y: point.y / 1.0)}
        case .medium:
            return points.map { point in
                CGPoint(x: point.x / 2.0, y: point.y / 2.0)}
        case .small:
            return points.map { point in
                CGPoint(x: point.x / 4.0, y: point.y / 4.0)}
        }
    }
 
    func hitSize() -> Double {
        switch self {
        case .large:
            return 50.0
        case .medium:
            return 25.0
        case .small:
            return 12.0
        }
    }
    
    func size() -> Double {
        switch self {
        case .large:
            return 1.0
        case .medium:
            return 2.0
        case .small:
            return 4.0
        }
    }
    
    func scores() -> Int {
        switch self {
        case .large:
            return 20
        case .medium:
            return 50
        case .small:
            return 100
        }
    }

    
}

#Preview {
    let previewEnvObject = GameManager()
    return AsteroidView(asteroid: previewEnvObject.asteroidArray[3])
        .environmentObject(previewEnvObject)
}
