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
                    //.background(.black)
                    .zIndex(3.0)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.black,.red,.orange, .red, .black]), startPoint: .top, endPoint: .bottom)
                    )
                Spacer()
                if manager.gameState == .intro {
                    StartView()
                } else if manager.gameState == .playing {
                    GameView()
                        .background(.black)
                        .zIndex(1.0)
                }
                Spacer()
                ControlsView()
                    .frame(width: UIScreen.main.bounds.width,height: 120,alignment: .center)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.black,.red,.orange, .red, .black]), startPoint: .top, endPoint: .bottom)
                    )
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

