//
//  HiScoreView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import SwiftUI

struct HiScoreView: View {
    @EnvironmentObject var manager: GameManager
#if os(iOS)
    static var titleTextSize:CGFloat = 24
    static var scoreTextSize:CGFloat = 24
    static var starttextSize:CGFloat = 30
#elseif os(tvOS)
    static var titleTextSize:CGFloat = 60
    static var scoreTextSize:CGFloat = 40
    static var starttextSize:CGFloat = 48
#endif
    var body: some View {
        let scores = manager.hiScores
        VStack {
            Spacer()
            Text("High Scores")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: HiScoreView.titleTextSize))
            Spacer()
            ForEach(scores.hiScores, id: \.self) {score in
                HStack{
                    Spacer()
                    Text("\(score.initials!)")
                        .foregroundStyle(.white)
                        .font(.custom("Hyperspace-Bold", size: HiScoreView.scoreTextSize))
                        .padding([.leading])
                    Spacer()
                    Text("\(String(format: "%06d", score.score))")
                        .foregroundStyle(.white)
                        .font(.custom("Hyperspace-Bold", size: HiScoreView.scoreTextSize))
                        .padding([.trailing])
                    Spacer()
                }
            }
            Spacer()
            Text("Press Fire to Start")
                .foregroundStyle(.red)
                .font(.custom("Hyperspace-Bold", size: HiScoreView.starttextSize))

        }.background(.clear)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return HiScoreView()
        .environmentObject(previewEnvObject)
    
}
