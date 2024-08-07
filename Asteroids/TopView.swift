//
//  TopView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

struct TopView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        VStack {
            Text("SwiftUI Asteroids")
                .foregroundStyle(.white)
                .font(.headline)
            HStack {
                Text("Lives: 3")
                    .foregroundStyle(.white)
                    .font(.headline)

                Text("Score: ")
                    .foregroundStyle(.white)
                    .font(.headline)
                Text(String(format: "%06d", manager.score))
                    .foregroundStyle(.white)
                Spacer()
            }
            
        }.background(.black)
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return TopView()
        .environmentObject(previewEnvObject)
    
}
