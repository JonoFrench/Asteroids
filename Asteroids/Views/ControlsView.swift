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
                .frame(width: 90, height: 90)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({_ in
                            if manager.gameState == .playing {
                                manager.shipLeft = true
                            }
                        })
                        .onEnded({_ in
                            if manager.gameState == .playing {
                                manager.shipLeft = false
                            }
                        })
                )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded({
                            if manager.gameState == .highscore {
                                manager.letterUp()
                            }
                        })
                )
            
            Spacer()
            VStack {
                Circle()
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [.red, .yellow, .orange, .purple]), center: .center, startRadius: 5, endRadius: 50)
                    )
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 80, height: 80)
                
                    .gesture(
                        TapGesture()
                            .onEnded({
                                if manager.gameState == .intro {
                                    manager.startNewGame()
                                } else if manager.gameState == .playing {
                                    manager.fireBullet()
                                } else if manager.gameState == .ended {
                                    manager.gameState = .intro
                                } else if manager.gameState == .highscore {
                                    manager.nextLetter()
                                }
                            })
                    )
                HStack {
                    Circle()
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [.blue,.gray, .white]), center: .center, startRadius: 5, endRadius: 50)
                        )
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 50, height: 50)
                        .gesture(
                            TapGesture()
                                .onEnded({_ in
                                    if manager.gameState == .playing {
                                        manager.hyperSpace()
                                    }
                                })
                        )
                    Spacer()
                    Circle()
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [.black,.gray, .white]), center: .center, startRadius: 5, endRadius: 50)
                        )
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 50, height: 50)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({_ in
                                    if manager.gameState == .playing {
                                        manager.startMovingShip()
                                    }
                                })
                                .onEnded({_ in
                                    manager.stopMovingShip()
                                })
                        )

                    
                }
            }
            Spacer()
            Circle()
                .fill(.red.gradient)
                .stroke(.white, lineWidth: 2)
                .frame(width: 90, height: 90)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({_ in
                            if manager.gameState == .playing {
                                manager.shipRight = true
                            }
                        })
                        .onEnded({_ in
                            if manager.gameState == .playing {
                                manager.shipRight = false
                            }
                        })
                )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded({
                            if manager.gameState == .highscore {
                                manager.letterDown()
                            }
                        })
                )
            Spacer()
        }
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ControlsView()
        .environmentObject(previewEnvObject)
    
}
