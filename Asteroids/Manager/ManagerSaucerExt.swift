//
//  ManagerSaucerExt.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import Foundation
import SwiftUI

extension GameManager {
    /// Saucer functions
    
    func addSaucer(){
        if Int.random(in: 0..<300) == 25 {
            let i = Int.random(in: 0...3)
            /// one in ten will be small to start with, later levels more so
            var rndSize = 9 - level
            if rndSize < 1 {rndSize = 1}
            let sSize = Int.random(in: 0...rndSize) == 1 ? UFOType.small : UFOType.large
            if i == 0 {
                /// Saucer from left edge = 0
                saucer = UFO(position: CGPoint(x: -widthPlus, y: Double.random(in: heightPlus...gameSize.height - heightPlus)),angle: Double.random(in: -45...45),velocity: 1.5, type: sSize)
            } else if i == 1 {
                /// Saucer from right edge = 180
                saucer = UFO(position: CGPoint(x: gameSize.width + widthPlus, y: Double.random(in: heightPlus...gameSize.height - heightPlus)),angle: Double.random(in: 135...225),velocity: 1.5, type: sSize)
            } else if i == 2 {
                /// Saucer from bottom edge = 270
                saucer = UFO(position: CGPoint(x: Double.random(in: widthPlus...gameSize.width - widthPlus), y: gameSize.height + heightPlus),angle: Double.random(in: 250...290),velocity: 1.5, type: sSize)
            } else {
                /// Saucer from top edge = 90
                saucer = UFO(position: CGPoint(x: Double.random(in: widthPlus...gameSize.width - widthPlus), y: -heightPlus),angle: Double.random(in: 45...135),velocity: 1.5, type: sSize)
            }
            hasSaucer = true
            if sSize == .large {
                startLargeSaucerSound()}
            else {
                startSmallSaucerSound()}
        }
    }
    
    func moveSaucer(){
        if hasSaucer {
            let newPos = moveAsset(from: saucer!.position, atAngle: saucer!.angle, withDistance: saucer!.velocity)
            saucer?.position = newPos
            if let pos = saucer?.position {
                if pos.x < -widthPlus || pos.x > gameSize.width + widthPlus || pos.y > gameSize.height + heightPlus || pos.y < -heightPlus {
                    saucer = nil
                    hasSaucer = false
                }
            }
        }
    }
    
    /// Saucer firing bullets
    func fireSaucer(){
        if hasSaucer && Int.random(in: 0..<100) == 25  {
            if let saucerUR = saucer {
                /// Small saucers have greater accuracy
                let accuracy = saucerUR.type == .large ? 40.0 : 80.0 + Double(level)
                saucerBullet = Bullet(position: saucerUR.position, angle: modifiedAngleBetweenPoints(point1: saucerUR.position, point2: shipPos, accuracy: accuracy), velocity: 3.0)
                hasSaucerBullet = true
            }
        }
    }
    
    /// Sound FX of the Large Saucer
    func startLargeSaucerSound(){
        if hasSaucer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                soundFX.bigUFOSound()
                startLargeSaucerSound()
            }
        }
    }
    
    /// Sound FX of the Small Saucer
    func startSmallSaucerSound(){
        if hasSaucer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                soundFX.smallUFOSound()
                startSmallSaucerSound()
            }
        }
    }
}
