//
//  GameManager.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//


//LargeAstPnts            = $02     ;20 points for a Large asteroid hit.
//MedAstPnts              = $05     ;50 points for medium asteroid hit.
//SmallAstPnts            = $10     ;100 points for a small asteroid hit.
//LargeScrPnts            = $20     ;200 points for a large saucer hit.
//SmallScrPnts            = $99     ;990 points for a small saucer hit.


import Foundation
import QuartzCore
import SwiftUI

enum GameState {
    case intro,getready,playing,ended
}

class GameManager: ObservableObject {
    
    var soundFX:SoundFX = SoundFX()
    @Published
    var lives = 3
    @Published
    var gameState:GameState = .intro
    @Published
    var shipAngle = 0.0
    @Published
    var shipTrajectoryAngle = 0.0
    var shipVelocity = CGPoint(x: 0.0, y: 0.0)
    var shipAcceleration = CGPoint(x: 0.0, y: 0.0)
    var shipThrust = 1.0
    var explosionTimer = 0
    var shipLeft = false
    var shipRight = false
    @Published
    var shipExploding = false
    @Published
    var shipExpA:ShipExplodingStruc?
    @Published
    var shipExpB:ShipExplodingStruc?
    @Published
    var shipExpC:ShipExplodingStruc?
    var shortPause = false
    @Published
    var isShipThrusting = false
    @Published
    var shipPos = CGPoint(x: 100.0, y: 100.0)
    @Published
    var bulletArray:[Bullet] = []
    @Published
    var asteroidArray:[Asteroid] = []
    @Published
    var explosionArray:[Explosion] = []
    @Published
    var UFObulletArray:[Bullet] = []
    @Published
    var UFOArray:[UFO] = []
    
    @Published
    var score = 0
    var level = 1
    var ufo = false
    var heartBeat = 0.8
    
    init() {
        ///Here we go, lets have a nice DisplayLink to update our model with the screen refresh.
        let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(refreshModel))
        displayLink.add(to: .main, forMode:.common)
    }
    
    @objc func refreshModel() {
        
        if gameState == .playing {
            /// Ship
            if shipLeft {
                rotateShipLeft()
            }
            if shipRight {
                rotateShipRight()
            }
            /// Bullets
            if bulletArray.count > 0 {
                moveBullet()
                checkBullets()
            }
            /// Asteroids
            moveAsteroids()
            ///Explosions
            animateExplosions()
            ///UFO
            
            
            /// Check level complete
            checkAsteroids()
            
            ///Check if anything nasty has happened to our ship
            ///Last to do as it's easy to test if we don't die hahahahaha
            if !shipExploding {
                moveShip()
                checkShip()
            } else {
                explodeShip()
            }
        }
    }
    
    func startGame() {
        gameState = .getready
        heartBeat = 0.8
        shipPos = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 2) - 150)
        asteroidArray.removeAll()
        addAsteroids()
        shipTrajectoryAngle = 0.0
        shipVelocity = CGPoint(x: 0.0, y: 0.0)
        shipAcceleration = CGPoint(x: 0.0, y: 0.0)
        shipThrust = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            gameState = .playing
            startHeartBeat()
        }
    }
    
    /// Sound FX of the beating game
    func startHeartBeat(){
        if gameState == .playing {
            DispatchQueue.main.asyncAfter(deadline: .now() + heartBeat) { [self] in
                soundFX.beat1Sound()
                DispatchQueue.main.asyncAfter(deadline: .now() + heartBeat) { [self] in
                    soundFX.beat2Sound()
                    startHeartBeat()
                }
            }
        }
    }

    func nextWave() {
        level += 1
        heartBeat = 0.8
        bulletArray.removeAll()
        startGame()
    }
    
    ///Check our ship hasn't been hit by an asteroid
    func checkShip() {
        for asteroid in asteroidArray {
            let aSize = asteroid.asteroidType.hitSize()
            if circlesIntersect(center1: asteroid.position, diameter1: aSize, center2: shipPos, diameter2: 10.0) {
            //if isPointWithinCircle(center: asteroid.position, diameter: aSize, point: shipPos) {
                print("Ship Hit!!!! by \(aSize)")
                shipExpA = ShipExplodingStruc(position: shipPos, points: sizedExpPointsA,angle: shipAngle)
                shipExpB = ShipExplodingStruc(position: shipPos, points: sizedExpPointsB,angle: adjustAngle(initialAngle: shipAngle, adjustment: 90))
                shipExpC = ShipExplodingStruc(position: shipPos, points: sizedExpPointsC,angle: adjustAngle(initialAngle: shipAngle, adjustment: -90))
                shipExploding = true
                soundFX.bigHitSound()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                    shipExploding = false
                    lives -= 1
                    
                    if lives > 0 {
                        gameState = .getready
                        shipPos = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 2) - 150)
                        shipTrajectoryAngle = 0.0
                        shipVelocity = CGPoint(x: 0.0, y: 0.0)
                        shipAcceleration = CGPoint(x: 0.0, y: 0.0)
                        shipThrust = 1.0
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                            gameState = .playing
                            startHeartBeat()
                        }
                    } else {
                        lives = 3
                        level = 1
                        gameState = .ended
                    }
                }
            }
        }
    }
    
    ///Todo next level
    func checkAsteroids() {
        if gameState == .playing && asteroidArray.isEmpty && !shortPause && !shipExploding {
            shortPause = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [self] in
                shortPause = false
                nextWave()
            }
        }
    }
    
    /// Add the asteroids at more random positions, plus we need to add more for each wave.
    func addAsteroids() {
        for _ in (0...2+level) {
            asteroidArray.append(Asteroid(position: randomPoint(), angle: randomAngle(), velocity: 1.0, type: .large,shape: randomShape()))
        }
    }
    
    func randomAngle() -> Double {
        return Double(Int.random(in: 0..<360))
    }
    
    func randomPoint() -> CGPoint {
        ///Todo make sure our point isn't on the ship though
        let x = Int.random(in: 0..<Int(UIScreen.main.bounds.width))
        let y = Int.random(in: 100..<Int(UIScreen.main.bounds.height)-100)
        return CGPoint(x: Double(x), y: Double(y))
    }
    
    func randomShape() -> AsteroidShape {
        let s = Int.random(in: 0..<4)
        if s == 0 { return .ShapeA}
        if s == 1 { return .ShapeB}
        if s == 2 { return .ShapeC}
        return .ShapeD
    }
    
    func startMovingShip() {
        shipTrajectoryAngle = shipAngle
        isShipThrusting = true
        soundFX.thrustSound()
        let radians = shipTrajectoryAngle * .pi / 180 // Convert angle to radians
        shipAcceleration.x += shipThrust * cos(radians)
        shipAcceleration.y += shipThrust * sin(radians)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            isShipThrusting = false
        }
        /// Bit of haptic feedback helps
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
        
    }
    
    func moveShip(){
        shipPos.x += shipVelocity.x * 0.6
        shipPos.y += shipVelocity.y * 0.6
        shipVelocity.x += shipAcceleration.x * 0.6
        shipVelocity.y += shipAcceleration.y * 0.6
        shipAcceleration = CGPoint()
        
        if shipPos.x < -20 {
            shipPos.x = UIScreen.main.bounds.width + 20
        }
        else if shipPos.x > UIScreen.main.bounds.width + 20 {
            shipPos.x = -20
        }
        else if shipPos.y < -20 {
            shipPos.y = UIScreen.main.bounds.height - 300
        }
        else if shipPos.y > UIScreen.main.bounds.height - 300 {
            shipPos.y = -20
        }
    }
    
    func explodeShip(){
        if shipExploding {
            let newPosA = moveAsset(from: shipExpA!.position, atAngle: shipExpA!.angle, withDistance: 1.0)
            shipExpA?.position = newPosA
            let newPosB = moveAsset(from: shipExpB!.position, atAngle: shipExpB!.angle, withDistance: 1.0)
            shipExpB?.position = newPosB
            let newPosC = moveAsset(from: shipExpC!.position, atAngle: shipExpC!.angle, withDistance: 1.0)
            shipExpC?.position = newPosC
        }
    }
    
    func stopMovingShip(){
        isShipThrusting = false
    }
    
    func rotateShipRight() {
        shipAngle += 5.0
        if shipAngle > 360.0 {
            shipAngle = 0.0
        }
    }
    
    func rotateShipLeft() {
        shipAngle -= 5.0
        if shipAngle < 0.0 {
            shipAngle = 360.0
        }
    }
    
    func fireBullet(){
        bulletArray.append(Bullet(position: shipPos, angle: shipAngle, velocity: 6.0))
        soundFX.fireSound()
        /// Bit of haptic feedback helps
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }
    
    func animateExplosions() {
        if explosionTimer == 4 {
            explosionTimer = 0
            var baIndexSet:IndexSet = []
            for (index,_) in explosionArray.enumerated() {
                explosionArray[index].frame += 1
                if explosionArray[index].frame == 4 {
                    baIndexSet.insert(index)
                }
            }
            explosionArray.remove(atOffsets: baIndexSet)
        }
        explosionTimer += 1
    }
    
    ///Todo implement hyperspace handling
    func hyperSpace() {
        print("hyperSpace")
    }
    
    func moveBullet(){
        if bulletArray.count > 0 {
            ///Remove any bullets that have gone out the screen
            var baIndexSet:IndexSet = []
            for (index,_) in bulletArray.enumerated(){
                if bulletArray[index].position.x < 0 || bulletArray[index].position.x > UIScreen.main.bounds.width || bulletArray[index].position.y < 0 || bulletArray[index].position.y > UIScreen.main.bounds.height {
                    baIndexSet.insert(index)
                }
            }
            bulletArray.remove(atOffsets: baIndexSet)
            
            ///Move the current bullets
            for (index,item) in bulletArray.enumerated(){
                bulletArray[index].position = moveAsset(from: item.position, atAngle: item.angle, withDistance: item.velocity)
            }
        }
    }
    
    func checkBullets(){
        if bulletArray.count > 0 {
            var baIndexSet:IndexSet = []
            var astIndexSet:IndexSet = []
            
            for (bulIndex,bullet) in bulletArray.enumerated(){
                for (index,asteroid) in asteroidArray.enumerated(){
                    if asteroid.checkHit(bulletPos: bullet.position) {
                        baIndexSet.insert(bulIndex)
                        astIndexSet.insert(index)
                    }
                }
            }
            
            bulletArray.remove(atOffsets: baIndexSet)
            for aIndex in astIndexSet {
                if asteroidArray.indices.contains(aIndex)  {
                    let astHit = asteroidArray[aIndex]
                    ///Update Score and add explosion shrapnel and remove the asteroid
                    score += astHit.asteroidType.scores()
                    heartBeat -= 0.01
                    explosionArray.append(Explosion(position: astHit.position, rotation: astHit.rotation))
                    asteroidArray.remove(at: aIndex)
                    /// Bit of haptic feedback helps
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    if astHit.asteroidType == .large {
                        soundFX.bigHitSound()
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAngle(), velocity: 1.2, type: .medium,shape: astHit.asteroidShape))
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAngle(), velocity: 1.2, type: .medium,shape: astHit.asteroidShape))
                        
                    } else if astHit.asteroidType == .medium {
                        soundFX.mediumHitSound()
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAngle(), velocity: 1.5, type: .small,shape: astHit.asteroidShape))
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAngle(), velocity: 1.5, type: .small,shape: astHit.asteroidShape))
                        
                    } else {
                        soundFX.smallHitSound()
                    }
                }
            }
        }
    }
    
    func moveAsteroids(){
        if asteroidArray.count > 0 {
            ///Move the asteroids
            for (index,item) in asteroidArray.enumerated(){
                asteroidArray[index].position = moveAsset(from: item.position, atAngle: item.angle, withDistance: item.velocity)
                if asteroidArray[index].angle < 180 {
                    asteroidArray[index].rotation += 2
                    if asteroidArray[index].rotation > 360 {
                        asteroidArray[index].rotation = 0
                    }
                } else {
                    asteroidArray[index].rotation += 2
                    if asteroidArray[index].rotation < 0 {
                        asteroidArray[index].rotation = 360
                    }
                }
            }
            
            for (index,_) in asteroidArray.enumerated(){
                if asteroidArray[index].position.x < -20 {
                    asteroidArray[index].position.x = UIScreen.main.bounds.width + 20
                }
                if asteroidArray[index].position.x > UIScreen.main.bounds.width + 20 {
                    asteroidArray[index].position.x = -20
                }
                if asteroidArray[index].position.y < -20 {
                    asteroidArray[index].position.y = UIScreen.main.bounds.height - 300
                }
                if asteroidArray[index].position.y > UIScreen.main.bounds.height - 300 {
                    asteroidArray[index].position.y = -20
                }
            }
        }
    }
    
    func moveAsset(from start: CGPoint, atAngle angle: CGFloat, withDistance distance: CGFloat) -> CGPoint {
        let radians = angle * .pi / 180 // Convert angle to radians
        let deltaX = distance * cos(radians)
        let deltaY = distance * sin(radians)
        let newX = start.x + deltaX
        let newY = start.y + deltaY
        return CGPoint(x: newX, y: newY)
    }
}
