//
//  SaucerView.swift
//  Asteroids
//
//  Created by Jonathan French on 5.08.24.
//

import SwiftUI

let sizedUFOPoints:[CGPoint] = UFOPoints.map { point in
    CGPoint(x: point.x / smallUFOSize, y: point.y / smallUFOSize)
}
struct SaucerView: View {
    @EnvironmentObject var manager: GameManager
    let rotatedPoints = rotatePoints(sizedUFOPoints, byDegrees: 180.0)
    var body: some View {
        ZStack {
            VectorShape(points: rotatedPoints)
                //.fill(.black)
                .stroke(.black,lineWidth: 1.0)
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
}

enum UFOType {
    case small,large
    
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
    return SaucerView()
        .environmentObject(previewEnvObject)
}
