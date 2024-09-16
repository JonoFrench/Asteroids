//
//  LevelView.swift
//  Asteroids
//
//  Created by Jonathan French on 8.08.24.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var manager: GameManager
#if os(iOS)
    static var titleTextSize:CGFloat = 36
#elseif os(tvOS)
    static var titleTextSize:CGFloat = 64
#endif

    var body: some View {
        VStack {
            Spacer()
            Text("Level \(manager.level)")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: LevelView.titleTextSize))
            Spacer()
            Text("Get Ready")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: LevelView.titleTextSize))
            Spacer()
        }.background(.clear)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return LevelView()
        .environmentObject(previewEnvObject)
    
}
