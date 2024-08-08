//
//  ExplosionView.swift
//  Asteroids
//
//  Created by Jonathan French on 6.08.24.
//

import SwiftUI

struct ExplosionView: View {
    @EnvironmentObject var manager: GameManager
    var explosion:Explosion
    var body: some View {
        let rotatedPoints = rotatePoints(explosion.points[explosion.frame].points, byDegrees: explosion.rotation)
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[0].x,y: rotatedPoints[0].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[1].x,y: rotatedPoints[1].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[2].x,y: rotatedPoints[2].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[3].x,y: rotatedPoints[3].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[4].x,y: rotatedPoints[4].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[5].x,y: rotatedPoints[5].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[6].x,y: rotatedPoints[6].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[7].x,y: rotatedPoints[7].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[8].x,y: rotatedPoints[8].y)
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
                .position(x: rotatedPoints[9].x,y: rotatedPoints[9].y)
        }.frame(width: 1,height: 1,alignment: .center)
        .background(.black)
            .zIndex(200)
    }
}

struct Explosion:Identifiable {
    var id = UUID()
    var position = CGPoint(x: 0, y: 0)
    var frame = 0
    var points:[ExplosionPoints] = [ExplosionPoints(points:explosionPoints4),ExplosionPoints(points:explosionPoints3),ExplosionPoints(points:explosionPoints2),ExplosionPoints(points:explosionPoints1)]
    var rotation  = 0.0
    
    init(position: CGPoint, frame: Int = 0, rotation: Double = 0.0) {
        self.position = position
        self.frame = frame
        self.rotation = rotation
    }
}

struct ExplosionPoints:Identifiable {
    var id = UUID()
    var points:[CGPoint]
    
    init(points: [CGPoint]) {
        self.points = points
    }
}



#Preview {
    let previewEnvObject = GameManager()
    return ExplosionView(explosion: Explosion(position: CGPoint(x: 200, y: 200)))
        .environmentObject(previewEnvObject)
}
