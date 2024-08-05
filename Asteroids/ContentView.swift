//
//  ContentView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        ZStack(alignment: .top) {
            Color(.black)
            VStack {
                TopView()
                    .frame(width: UIScreen.main.bounds.width,height: 100, alignment: .center)
                    .background(.gray)
                    .zIndex(3.0)
                Spacer()
                GameView()
                    .background(.black)
                    .zIndex(1.0)
                Spacer()
                ControlsView()
                    .frame(width: UIScreen.main.bounds.width,height: 120,alignment: .center)
                    .background(.yellow)
                    .zIndex(2.0)
            }
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ContentView()
        .environmentObject(previewEnvObject)
}

