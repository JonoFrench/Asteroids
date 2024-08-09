//
//  NewHighScoreView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import SwiftUI

struct NewHighScoreView: View {
    @EnvironmentObject var manager: GameManager
    @State private var initialIndex = 0
    var body: some View {
        VStack {
            Spacer()
            Text("New High Score")
                .foregroundStyle(.red)
                .font(.custom("Hyperspace-Bold", size: 36))
            Spacer()
            Text("Enter your initials")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 28))
            //Spacer()

            HStack {
                Spacer()
                Text(String(manager.letterArray[0]))
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 38))
                    .padding() // Add some padding around the letter
                    .border(manager.letterIndex == 0 ? Color.red : Color.white , width: 2)
                Spacer()
                Text(String(manager.letterArray[1]))
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 38))
                    .padding() // Add some padding around the letter
                    .border(manager.letterIndex == 1 ? Color.red : Color.white, width: 2)
                Spacer()
                Text(String(manager.letterArray[2]))
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 38))
                    .padding() // Add some padding around the letter
                    .border(manager.letterIndex == 2 ? Color.red : Color.white, width: 2)
                Spacer()
                
            }
            Spacer()
            Text("Press Left / Right")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 18))
            Text("Fire to select")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 18))

            Spacer()
        }.background(.clear)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return NewHighScoreView()
        .environmentObject(previewEnvObject)
    
}
