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
#if os(iOS)
        HStack {
            Spacer()
            ZStack {
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
                Text("\(Image(systemName: "arcade.stick.and.arrow.left"))")
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                .allowsHitTesting(false)
            }

            Spacer()
            VStack {
                ZStack {
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
                                } else if manager.gameState == .playing && !manager.shipExploding {
                                    manager.fireBullet()
                                    let impactHev = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHev.impactOccurred()

                                } else if manager.gameState == .ended {
                                    manager.gameState = .intro
                                } else if manager.gameState == .highscore {
                                    manager.nextLetter()
                                }
                            })
                    )
                Text("\(Image(systemName: "laser.burst"))")
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                    .allowsHitTesting(false)
                }

                
                HStack {
                    ZStack {
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
                                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                            impactMed.impactOccurred()

                                        }
                                    })
                            )
                        Text("H")
                                .foregroundColor(.white)
                        .allowsHitTesting(false)
                    }
                    Spacer()
                    ZStack {
                        
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

                                            let impactHev = UIImpactFeedbackGenerator(style: .soft)
                                            impactHev.impactOccurred()
                                        }
                                    })
                                    .onEnded({_ in
                                        manager.stopMovingShip()
                                    })
                            )
                        Text("\(Image(systemName: "chevron.forward.circle"))")
                                .foregroundColor(.white)
                                .font(.system(size: 36))
                                .allowsHitTesting(false)
                    }
                }
            }
            Spacer()
            ZStack {
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
            Text("\(Image(systemName: "arcade.stick.and.arrow.right"))")
                    .foregroundColor(.white)
                    .font(.system(size: 36))
                .allowsHitTesting(false)
            }

            Spacer()
        }
        #endif
    }
}

#Preview {
    let previewEnvObject = GameManager()
    return ControlsView()
        .environmentObject(previewEnvObject)
    
}
