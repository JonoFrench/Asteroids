//
//  ShipView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

let sizedPoints:[CGPoint] = shipPoints.map { point in
    CGPoint(x: point.x / shipSize, y: point.y / shipSize)
}

let sizedThrustPoints:[CGPoint] = shipThrustPoints.map { point in
    CGPoint(x: point.x / shipSize, y: point.y / shipSize)
}

struct ShipView: View {
    @EnvironmentObject var manager: GameManager

    var body: some View {
        let rotatedPoints = rotatePoints(sizedPoints, byDegrees: manager.shipAngle)
        let rotatedThrustPoints = rotatePoints(sizedThrustPoints, byDegrees: manager.shipAngle)
        ZStack {
            VectorShape(points: rotatedPoints)
                .fill(.black)
                .stroke(.white,lineWidth: 1.0)
                .frame(width: 1,height: 1,alignment: .center)
                .background(.black)
            if manager.isShipThrusting {
                VectorShape(points: rotatedThrustPoints)
                    .fill(.black)
                    .stroke(.white,lineWidth: 1.0)
                    .frame(width: 1,height: 1,alignment: .center)
                    .background(.black)
            }
        }
            .background(.blue)
            .zIndex(150.0)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ShipView()
        .environmentObject(previewEnvObject)
}

