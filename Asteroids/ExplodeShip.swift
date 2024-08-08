//
//  ExplodeShip.swift
//  Asteroids
//
//  Created by Jonathan French on 8.08.24.
//

import SwiftUI

let sizedExpPointsA:[CGPoint] = shipPartA.map { point in
    CGPoint(x: point.x / shipSize, y: point.y / shipSize)
}

let sizedExpPointsB:[CGPoint] = shipPartB.map { point in
    CGPoint(x: point.x / shipSize, y: point.y / shipSize)
}

let sizedExpPointsC:[CGPoint] = shipPartC.map { point in
    CGPoint(x: point.x / shipSize, y: point.y / shipSize)
}

struct ExplodeShip: View {
    @EnvironmentObject var manager: GameManager
    var explodingBits:ShipExplodingStruc
    var body: some View {
        let rotatedPoints = rotatePoints(explodingBits.points, byDegrees: manager.shipAngle)
        ZStack {
            VectorLine(points: rotatedPoints)
                .stroke(.white,lineWidth: 1.0)
                .frame(width: 1,height: 1,alignment: .center)
        }.zIndex(200.0)
    }

}

struct ShipExplodingStruc:Identifiable {
    var id = UUID()
    var position = CGPoint()
    var points:[CGPoint] = []
    var angle:CGFloat = 0.0
    
    init(position: CGPoint, points: [CGPoint],angle: Double) {
        self.position = position
        self.points = points
        self.angle = angle
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ExplodeShip(explodingBits: ShipExplodingStruc(position: CGPoint(), points: sizedExpPointsA,angle: 0.0))
        .environmentObject(previewEnvObject)
}
