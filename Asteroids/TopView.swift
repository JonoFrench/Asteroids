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
            HStack {
                Spacer()
                Text("Lives: 3")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 24))
                Spacer()
                Text("Score: \(String(format: "%06d", manager.score))")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 24))
                    .frame(alignment: .trailing)
                Spacer()
            }.onAppear {
                print("Hello")
                for family: String in UIFont.familyNames
                {
                    print(family)
                    for names: String in UIFont.fontNames(forFamilyName: family)
                    {
                        print("== \(names)")
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return TopView()
        .environmentObject(previewEnvObject)
    
}
