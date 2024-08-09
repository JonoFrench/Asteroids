//
//  HiScoreView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import SwiftUI

struct HiScoreView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        let scores = manager.hiScores
        VStack {
            Spacer()
            Text("High Scores")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 36))
            
            ForEach(scores.hiScores, id: \.self) {score in
                HStack{
                    Spacer()
                    Text("\(score.initials!)")
                        .foregroundStyle(.white)
                        .font(.custom("Hyperspace-Bold", size: 28))
                        .padding([.leading])
                    Spacer()
                    Text("\(String(format: "%06d", score.score))")
                        .foregroundStyle(.white)
                        .font(.custom("Hyperspace-Bold", size: 28))
                        .padding([.trailing])
                    Spacer()
                }
            }
            Spacer()
            Text("Press Fire to Start")
                .foregroundStyle(.red)
                .font(.custom("Hyperspace-Bold", size: 30))

        }.background(.clear)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return HiScoreView()
        .environmentObject(previewEnvObject)
    
}
