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
                    .zIndex(3.0)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear,.red,.orange, .red, .clear]), startPoint: .top, endPoint: .bottom)
                    )
                Spacer()
                if manager.gameState == .intro {
                    StartView()
                        .background(.clear)
                } else if manager.gameState == .getready {
                    LevelView()
                        .background(.clear)
                        .zIndex(1.0)
                }  else if manager.gameState == .playing {
                        GameView()
                            .background(.clear)
                            .zIndex(1.0)
                } else if manager.gameState == .ended {
                    GameOverView()
                        .background(.clear)
                        .zIndex(1.0)
                }
                Spacer()
                ControlsView()
                    .frame(width: UIScreen.main.bounds.width,height: 120,alignment: .center)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear,.red,.orange, .red, .clear]), startPoint: .top, endPoint: .bottom)
                    )
                    .zIndex(2.0)
            }.background(
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ContentView()
        .environmentObject(previewEnvObject)
}

