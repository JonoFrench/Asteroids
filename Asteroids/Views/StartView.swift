//
//  StartView.swift
//  Asteroids
//
//  Created by Jonathan French on 7.08.24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
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
    }
}

#Preview {
    StartView()
}
