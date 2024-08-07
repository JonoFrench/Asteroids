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
                .font(.title)

            Spacer()
            Text("Press Fire to Start")
                .foregroundStyle(.white)
                .font(.title)
            Spacer()
            Text("(c) Jonathan French 2024")
                .foregroundStyle(.white)
                .font(.footnote)
            Spacer()

        }.background(.black)
    }
}

#Preview {
    StartView()
}
