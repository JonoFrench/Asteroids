//
//  GameView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        ZStack {
            if !manager.shipExploding {
                ShipView()
                    .position(x:manager.shipPos.x,y:manager.shipPos.y)
            } else {
                ExplodeShip(explodingBits: manager.shipExpA!)
                    .position(x:manager.shipExpA!.position.x,y:manager.shipExpA!.position.y)
                ExplodeShip(explodingBits: manager.shipExpB!)
                    .position(x:manager.shipExpB!.position.x,y:manager.shipExpB!.position.y)
                ExplodeShip(explodingBits: manager.shipExpC!)
                    .position(x:manager.shipExpC!.position.x,y:manager.shipExpC!.position.y)
            }
            ForEach(manager.bulletArray, id: \.id) { bullet in
                BulletView()
                    .position(bullet.position)
            }
            ForEach(manager.asteroidArray, id: \.id) { asteroid in
                AsteroidView(asteroid: asteroid)
                    .position(asteroid.position)
            }
            ForEach(manager.explosionArray, id: \.id) { explosion in
                ExplosionView(explosion: explosion)
                    .position(explosion.position)
            }

        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return GameView()
        .environmentObject(previewEnvObject)
    
}
