//
//  BulletView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

struct BulletView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 2, height: 2)
        }.background(.clear)
            .zIndex(0.1)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return BulletView()
        .environmentObject(previewEnvObject)
}

struct Bullet:Identifiable {
    var id = UUID()
    var position = CGPoint(x: 0, y: 0)
    var angle = 0.0
    var velocity = 10.0
}

