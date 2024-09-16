//
//  GameManager+TV.swift
//  Asteroids
//
//  Created by Jonathan French on 16.09.24.
//

import Foundation
#if os(tvOS)
import GameController
#endif

extension GameManager {
    
#if os(tvOS)
    @objc func controllerDidConnect(notification: Notification) {
        if let controller = notification.object as? GCController {
            // Set up your controller
            setupController(controller)
        }
    }

    @objc func controllerDidDisconnect(notification: Notification) {
        // Handle controller disconnection if needed
    }
    #endif
    
#if os(tvOS)
    
    func setupController(_ controller: GCController) {
        if let gamepad = controller.extendedGamepad {
            // Respond to button presses and axis movements
            gamepad.buttonA.pressedChangedHandler = { [self] (button, value, pressed) in
                if pressed {
                    DispatchQueue.main.async { [self] in
                        print("Button A pressed")
                            if gameState == .intro {
                                startNewGame()
                            } else if gameState == .playing {
                                fireBullet()
                            } else if gameState == .ended {
                                gameState = .intro
                            } else if gameState == .highscore {
                                nextLetter()
                            }
                    }
                }
                
                gamepad.buttonX.pressedChangedHandler = { [self] (button, value, pressed) in
                    if pressed {
                        DispatchQueue.main.async { [self] in
                            print("Button X pressed")
                            if gameState == .playing {
                                startMovingShip()
                            }
                        }
                        if !pressed {
                            stopMovingShip()
                        }
                    }
                }

                gamepad.buttonY.pressedChangedHandler = { [self] (button, value, pressed) in
                    if pressed {
                        DispatchQueue.main.async { [self] in
                            print("Button Y pressed")
                            if gameState == .playing {
                                hyperSpace()
                            }
                        }
                    }
                }

                
                gamepad.dpad.valueChangedHandler = {[unowned self] _, xValue, yValue in
                    //                print("Dpad moved: x = \(xValue), y = \(yValue)")
                    DispatchQueue.main.async { [self] in
                        if xValue == -0.0 && yValue == 0.0 {
                            if gameState == .playing {
                                shipLeft = false
                                shipRight = false
                            }
                        } else
                        if xValue < 0.0 {
                            if gameState == .playing {
                                shipLeft = true
                            }
                        } else
                        if xValue > 0.0 {
                            if gameState == .playing {
                                shipRight = true
                            }
                        } else
                        if yValue < 0.0 {
                            if gameState == .highscore {
                                letterDown()
                            }
                        } else
                        if yValue > 0.0 {
                            if gameState == .highscore {
                                letterUp()
                            }
                        }
                    }
                }
                
//                gamepad.leftThumbstick.valueChangedHandler = { [self] (dpad, xValue, yValue) in
//                    //                print("Left thumbstick moved: x = \(xValue), y = \(yValue)")
//                    if xValue == -0.0 && yValue == 0.0 {
//                        if gameState == .playing {
//                            self.moveDirection = .stop
//                        }
//                    } else
//                    if xValue < 0.0 {
//                        if gameState == .playing {
//                            self.moveDirection = .left
//                        }
//                    } else
//                    if xValue > 0.0 {
//                        if gameState == .playing {
//                            self.moveDirection = .right
//                        }
//                    } else
//                    if yValue < 0.0 {
//                        if gameState == .playing {
//                            self.moveDirection = .down
//                        } else if gameState == .highscore {
//                            hiScores.letterDown()
//                        }
//                    } else
//                    if yValue > 0.0 {
//                        if gameState == .playing {
//                            self.moveDirection = .up
//                        } else if gameState == .highscore {
//                            hiScores.letterUp()
//                        }
//                    }
//                }
            }
        }
    }
    
    
    
#endif
    
}
