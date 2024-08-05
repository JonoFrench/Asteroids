//
//  SaucerView.swift
//  Asteroids
//
//  Created by Jonathan French on 5.08.24.
//

import SwiftUI

struct SaucerView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        ZStack {
            Text("I will be a saucer")
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return SaucerView()
        .environmentObject(previewEnvObject)
}
