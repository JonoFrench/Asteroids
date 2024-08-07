//
//  GameOverView.swift
//  Asteroids
//
//  Created by Jonathan French on 7.08.24.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        Text("GameOver")
            .foregroundStyle(.white)
            .font(.custom("Hyperspace-Bold", size: 36))
    }
}

#Preview {
    GameOverView()
}
