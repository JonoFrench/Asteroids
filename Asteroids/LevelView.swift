//
//  LevelView.swift
//  Asteroids
//
//  Created by Jonathan French on 8.08.24.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        VStack {
            Spacer()
            Text("Level \(manager.level)")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 36))
            Spacer()
            Text("Get Ready")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 36))
            Spacer()
        }.background(.clear)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return LevelView()
        .environmentObject(previewEnvObject)
    
}
