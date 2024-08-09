//
//  IntroView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import SwiftUI

struct IntroView: View {
    @State private var currentIndex = 0
    private let numberOfViews = 3
    var body: some View {
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
        }.background(.clear)
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
