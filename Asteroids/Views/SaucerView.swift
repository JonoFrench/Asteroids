//
//  SaucerView.swift
//  Asteroids
//
//  Created by Jonathan French on 5.08.24.
//

import SwiftUI

//let sizedUFOPoints:[CGPoint] = UFOPoints.map { point in
//    CGPoint(x: point.x / UFOSize, y: point.y / UFOSize)
//}
//
//let sizedSmallUFOPoints:[CGPoint] = UFOPoints.map { point in
//    CGPoint(x: point.x / smallUFOSize, y: point.y / smallUFOSize)
//}
struct SaucerView: View {
    @EnvironmentObject var manager: GameManager
    var saucer:UFO
    //let rotatedPoints = rotatePoints(sizedUFOPoints, byDegrees: 180.0)
    var body: some View {
        let rotatedPoints = rotatePoints(saucer.points, byDegrees: 180.0)
        ZStack {
            VectorShape(points: rotatedPoints)
                //.fill(.black)
                .stroke(.white,lineWidth: 1.0)
                .frame(width: 1,height: 1,alignment: .center)
                .background(.black)
        }.background(.gray)
    }
}

struct UFO:Identifiable {
    var id = UUID()
    var position = CGPoint(x: 0, y: 0)
    var angle = 0.0
    var velocity = 10.0
    var type:UFOType = .large
    var points:[CGPoint]
    var shape:[CGPoint] = UFOPoints

    init(position: CGPoint, angle: Double = 0.0, velocity: Double = 10.0, type: UFOType) {
        self.position = position
        self.angle = angle
        self.velocity = velocity
        self.type = type
        self.points = type.shape(points: shape)
    }
}

enum UFOType {
    case small,large
    
    func shape(points: [CGPoint]) -> [CGPoint] {
        switch self {
        case .large:
            return points.map { point in
                CGPoint(x: point.x / UFOSize, y: point.y / UFOSize)}
        case .small:
            return points.map { point in
                CGPoint(x: point.x / smallUFOSize, y: point.y / smallUFOSize)}
        }
    
    
//    func points() -> [CGPoint] {
//        switch self {
//        case .small:
//            return largeAsteroidPoints1
//        case .large:
//            return largeAsteroidPoints2
//        }
    }
    
    func scores() -> Int {
        switch self {
        case .large:
            return 200
        case .small:
            return 990
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return SaucerView(saucer: UFO(position: CGPoint(), type: .large))
        .environmentObject(previewEnvObject)
}
