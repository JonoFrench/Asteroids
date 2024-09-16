//
//  IntroView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var manager: GameManager
    @State private var currentIndex = 0
    private let numberOfViews = 3
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $currentIndex) {
                if currentIndex == 0 {
                    StartView()
                } else if currentIndex == 1 {
                    InfoView()
                } else {
                    HiScoreView()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                startTimer()
                print("game size \(proxy.size)")
                manager.gameSize = proxy.size
                manager.shipStartPos = CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }.background(.clear)
        }
    }
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            withAnimation {
                currentIndex = (currentIndex + 1) % numberOfViews
            }
        }
    }}

#Preview {
    IntroView()
}
