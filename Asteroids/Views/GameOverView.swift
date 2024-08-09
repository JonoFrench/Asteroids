//
//  GameOverView.swift
//  Asteroids
//
//  Created by Jonathan French on 7.08.24.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        Spacer()
        Text("Game Over")
            .foregroundStyle(.white)
            .font(.custom("Hyperspace-Bold", size: 36))
        Spacer()
        Text("Press Fire")
            .foregroundStyle(.white)
            .font(.custom("Hyperspace-Bold", size: 36))
    }
}

#Preview {
    GameOverView()
}
