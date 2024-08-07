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
                .fill(.red.gradient)
                .stroke(.white, lineWidth: 2)
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
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [.red, .yellow, .blue, .purple]), center: .center, startRadius: 5, endRadius: 50)
                    )
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 100, height: 50)
                
                    .gesture(
                        TapGesture()
                            .onEnded({
                                if manager.gameState == .intro {
                                    manager.gameState = .playing
                                } else {
                                    manager.fireBullet()
                                }
                            })
                    )
                Circle()
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [.black,.gray, .white]), center: .center, startRadius: 5, endRadius: 50)
                    )
                    .stroke(.white, lineWidth: 2)
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
                .fill(.red.gradient)
                .stroke(.white, lineWidth: 2)
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
        }//.background(
//            LinearGradient(gradient: Gradient(colors: [.black, .red, .black]), startPoint: .top, endPoint: .bottom)
//        )
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ControlsView()
        .environmentObject(previewEnvObject)
    
}
