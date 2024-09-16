//
//  StartView.swift
//  Asteroids
//
//  Created by Jonathan French on 7.08.24.
//

import SwiftUI

struct StartView: View {
#if os(iOS)
    static var starttextSize:CGFloat = 30
    static var copyTextSize:CGFloat = 18
#elseif os(tvOS)
    static var starttextSize:CGFloat = 48
    static var copyTextSize:CGFloat = 36
#endif

    @EnvironmentObject var manager: GameManager
    var body: some View {
//        GeometryReader { proxy in
            VStack {
                Spacer()
                Image("Title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("In SwiftUI")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: StartView.copyTextSize))
                Spacer()
                Text("Press Fire to Start")
                    .foregroundStyle(.red)
                    .font(.custom("Hyperspace-Bold", size: StartView.starttextSize))
                Spacer()
                Text("Jonathan French 2024")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: StartView.copyTextSize))
                Spacer()
                Text("(C) 1979 ATARI INC")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: StartView.copyTextSize))
                Spacer()
            }.background(.clear)
//                .onAppear {
//                    print("game size \(proxy.size)")
//                    manager.gameSize = proxy.size
//                    manager.shipStartPos = CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2)
//                }
//        }
    }
}

#Preview {
    StartView()
}
