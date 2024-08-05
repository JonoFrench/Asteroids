//
//  ControlsView.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var manager: GameManager
    var body: some View {
        HStack {
            Spacer()
            Circle()
                .fill(.white)
                .frame(width: 100, height: 100)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({_ in
                            manager.shipLeft = true
                        })
                        .onEnded({_ in
                            manager.shipLeft = false
                        })
                )
            Spacer()
            VStack {
                Circle()
                    .fill(.red)
                    .frame(width: 100, height: 50)
                    .gesture(
                        TapGesture()
                            .onEnded({
                                manager.fireBullet()
                            })
                    )
                Circle()
                    .fill(.white)
                    .frame(width: 100, height: 50)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({_ in
                                manager.startMovingShip()
                            })
                            .onEnded({_ in
                                manager.stopMovingShip()
                            })
                    )
            }
            Spacer()
            Circle()
                .fill(.white)
                .frame(width: 100, height: 100)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({_ in
                            manager.shipRight = true
                        })
                        .onEnded({_ in
                            manager.shipRight = false
                        })
                )
            Spacer()
        }.background(.green)
        //._fill()
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ControlsView()
        .environmentObject(previewEnvObject)
    
}
