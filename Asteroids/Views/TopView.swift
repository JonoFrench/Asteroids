//
//  TopView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

struct TopView: View {
    @EnvironmentObject var manager: GameManager
#if os(iOS)
    static var scoreTextSize:CGFloat = 24
#elseif os(tvOS)
    static var scoreTextSize:CGFloat = 48
#endif
    var body: some View {
        VStack {
            HStack {
                HStack(alignment:.firstTextBaseline ,content:
                {
                    ForEach(0..<manager.lives, id: \.self) {_ in
                        ShipLifeView().padding([.leading])
                    }
                })
                Spacer()
                Text("Score:\(String(format: "%06d", manager.score))")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: TopView.scoreTextSize))
                    .padding([.trailing])
            }
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return TopView()
        .environmentObject(previewEnvObject)
    
}
