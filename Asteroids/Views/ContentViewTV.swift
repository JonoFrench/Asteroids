//
//  ContentViewTV.swift
//  Asteroids
//
//  Created by Jonathan French on 16.09.24.
//

import SwiftUI

struct ContentViewTV: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ZStack(alignment: .top) {
                Color(.black)
                VStack(alignment: .center) {
                    TopView()
                        .frame(height: 100, alignment: .center)
                        .zIndex(3.0)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.clear,.red,.orange, .red, .clear]), startPoint: .top, endPoint: .bottom)
                        )
                   // Spacer()
                    if manager.gameState == .intro {
                        IntroView()
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
                    else if manager.gameState == .highscore {
                        NewHighScoreView()
                            .background(.clear)
                            .zIndex(1.0)
                    }
                    Spacer()
                }.background(
                    Image("GameBackground")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                )
            }.frame(width: UIScreen.main.bounds.height , height: UIScreen.main.bounds.height,alignment: .center)
                .clipped()
            Spacer()
        }.frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height,alignment: .center)
            .background(.black)
            .zIndex(100)
//        ZStack {
//            Button(""){
//            }.buttonStyle(PlainButtonStyle())
//            .background(.clear)
//            .onExitCommand {
//            }.frame(width: 0,height: 0)
//        }.zIndex(0.1)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ContentViewTV()
        .environmentObject(previewEnvObject)
}
