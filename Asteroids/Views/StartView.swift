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
    @State private var fontSize = 12.0 //36

    @EnvironmentObject var manager: GameManager
    var body: some View {
//        GeometryReader { proxy in
            VStack {
                Spacer()
                Image("Title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(" ")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: StartView.copyTextSize))
                Spacer()
                Text("Press Fire to Start")
                    .foregroundStyle(.red)
                    .font(.custom("Hyperspace-Bold", size: fontSize))
                    .frame(maxWidth: .infinity,maxHeight: 80)
                    .multilineTextAlignment(.center)
                Spacer()
                Text("© Jonathan French 2026")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: StartView.copyTextSize))
                Spacer()
                Text(" ")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: StartView.copyTextSize))
                Spacer()
            }.background(.clear)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1.5)) {
                    fontSize = 30
                }
                
            }
    }
}

#Preview {
    StartView()
}
