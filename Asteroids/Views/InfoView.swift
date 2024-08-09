//
//  InfoView.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

//LargeAstPnts            = $02     ;20 points for a Large asteroid hit.
//MedAstPnts              = $05     ;50 points for medium asteroid hit.
//SmallAstPnts            = $10     ;100 points for a small asteroid hit.
//LargeScrPnts            = $20     ;200 points for a large saucer hit.
//SmallScrPnts            = $99     ;990 points for a small saucer hit.



import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Scoring")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 30))
            Spacer()

            HStack {
                Spacer()
                HStack(alignment:.firstTextBaseline ,content:
                {
                    AsteroidView(asteroid: Asteroid(position: CGPoint(), type: .large, shape: .ShapeA) ).padding([.leading])
                })
                Spacer()
                Text("Large Asteroid 20 Pts")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 16))
                    .padding([.trailing])
                Spacer()
            }
            Spacer()
            
            HStack {
                Spacer()
                HStack(alignment:.firstTextBaseline ,content:
                {
                    AsteroidView(asteroid: Asteroid(position: CGPoint(), type: .medium, shape: .ShapeB) ).padding([.leading])
                })
                Spacer()
                Text("Medium Asteroid 50 Pts")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 16))
                    .padding([.trailing])
                Spacer()
            }
            Spacer()

            HStack {
                Spacer()
                HStack(alignment:.firstTextBaseline ,content:
                {
                    AsteroidView(asteroid: Asteroid(position: CGPoint(), type: .small, shape: .ShapeC) ).padding([.leading])
                })
                Spacer()
                Text("Small Asteroid 100 Pts")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 16))
                    .padding([.trailing])
                Spacer()
            }
            Spacer()

            HStack {
                Spacer()
                HStack(alignment:.firstTextBaseline ,content:
                {
                    SaucerView(saucer: UFO(position: CGPoint(), type: .large)).padding([.leading])
                })
                Spacer()
                Text("Large Saucer 200 Pts")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 16))
                    .padding([.trailing])
                Spacer()
            }
            Spacer()
          
            HStack {
                Spacer()
                HStack(alignment:.firstTextBaseline ,content:
                {
                    SaucerView(saucer: UFO(position: CGPoint(), type: .small)).padding([.leading])
                })
                Spacer()
                Text("Small Saucer 990 Pts")
                    .foregroundStyle(.white)
                    .font(.custom("Hyperspace-Bold", size: 16))
                    .padding([.trailing])
                Spacer()
            }
            Spacer()
            Text("Extra life every 10000 pts")
                .foregroundStyle(.white)
                .font(.custom("Hyperspace-Bold", size: 16))

            Spacer()
            Text("Press Fire to Start")
                .foregroundStyle(.red)
                .font(.custom("Hyperspace-Bold", size: 30))
        }.background(.clear)
    }
}

#Preview {
    InfoView()
}
