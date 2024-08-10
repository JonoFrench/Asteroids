//
//  StartView.swift
//  Asteroids
//
//  Created by Jonathan French on 7.08.24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                Image("Title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("In SwiftUI")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 36))
                Spacer()
                Text("Press Fire to Start")
                    .foregroundStyle(.red)
                    .font(.custom("Hyperspace-Bold", size: 30))
                Spacer()
                Text("Jonathan French 2024")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 18))
                Spacer()
                Text("(C) 1979 ATARI INC")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 18))
                Spacer()
            }.background(.clear)
                .onAppear {
                    print("game size \(proxy.size)")
                    manager.gameSize = proxy.size
                    manager.shipStartPos = CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2)
                }
        }
    }
}

#Preview {
    StartView()
}
