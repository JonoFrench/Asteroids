//
//  NewHighScoreView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import SwiftUI

struct NewHighScoreView: View {
#if os(iOS)
    static var titleTextSize:CGFloat = 36
    static var subTitleTextSize:CGFloat = 28
    static var letterTextSize:CGFloat = 38
    static var starttextSize:CGFloat = 30
    static var infoTextSize:CGFloat = 18
#elseif os(tvOS)
    static var titleTextSize:CGFloat = 72
    static var subTitleTextSize:CGFloat = 56
    static var letterTextSize:CGFloat = 76
    static var starttextSize:CGFloat = 48
    static var infoTextSize:CGFloat = 36
#endif
    @EnvironmentObject var manager: GameManager
    @State private var initialIndex = 0
    var body: some View {
        VStack {
            Spacer()
            Text("New High Score")
                .foregroundStyle(.red)
                .font(.custom("Hyperspace-Bold", size: NewHighScoreView.titleTextSize))
            Spacer()
            Text("Enter your initials")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: NewHighScoreView.subTitleTextSize))
            //Spacer()

            HStack {
                Spacer()
                Text(String(manager.letterArray[0]))
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: NewHighScoreView.letterTextSize))
                    .padding() // Add some padding around the letter
                    .border(manager.letterIndex == 0 ? Color.red : Color.white , width: 2)
                Spacer()
                Text(String(manager.letterArray[1]))
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: NewHighScoreView.letterTextSize))
                    .padding() // Add some padding around the letter
                    .border(manager.letterIndex == 1 ? Color.red : Color.white, width: 2)
                Spacer()
                Text(String(manager.letterArray[2]))
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: NewHighScoreView.letterTextSize))
                    .padding() // Add some padding around the letter
                    .border(manager.letterIndex == 2 ? Color.red : Color.white, width: 2)
                Spacer()
                
            }
            Spacer()
            Text("Press Left / Right")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: NewHighScoreView.infoTextSize))
            Text("Fire to select")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: NewHighScoreView.infoTextSize))

            Spacer()
        }.background(.clear)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return NewHighScoreView()
        .environmentObject(previewEnvObject)
    
}
