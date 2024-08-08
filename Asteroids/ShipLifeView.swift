//
//  ShipLife.swift
//  Asteroids
//
//  Created by Jonathan French on 8.08.24.
//

import SwiftUI

struct ShipLifeView: View {
    var body: some View {
        let rotatedPoints = rotatePoints(sizedPoints, byDegrees: 270)
        ZStack {
            VectorShape(points: rotatedPoints)
                .fill(.clear)
                .stroke(.white,lineWidth: 1.0)
                .frame(width: 1,height: 1,alignment: .center)
                .background(.clear)
        }
            .background(.clear)
    }
}

#Preview {
    ShipLifeView()
}
