//
//  GameManager.swift
//  Asteroids
//
//  Created by Jonathan French on 4.08.24.
//


import Foundation
import QuartzCore
import SwiftUI

enum GameState {
    case intro,getready,playing,ended,highscore
}

class GameManager: ObservableObject {
    let hiScores:AsteroidHighScores = AsteroidHighScores()
    let soundFX:SoundFX = SoundFX()
    var gameSize = CGSize()
/// gameSize +- for checking ship off screen and appearing on the other side.
    let widthPlus = 20.0
    let heightPlus = 30.0
    let widthAsteroidPlus = 40.0
    let heightAsteroidPlus = 50.0

    @Published
    var lives = 3
    @Published
    var gameState:GameState = .intro
    @Published
    var shipAngle = 270.0
    var shipTrajectoryAngle = 0.0
    var shipVelocity = CGPoint()
    var shipAcceleration = CGPoint()
    var shipThrust = 1.0
    var shipStartPos = CGPoint()
    var explosionTimer = 0
    var shipLeft = false
    var shipRight = false
    var shipExploding = false
    var shipExpA:ShipExplodingStruc?
    var shipExpB:ShipExplodingStruc?
    var shipExpC:ShipExplodingStruc?
    var shortPause = false
    var isShipThrusting = false
    @Published
    var shipPos = CGPoint()
    @Published
    var bulletArray:[Bullet] = []
    @Published
    var asteroidArray:[Asteroid] = []
    @Published
    var explosionArray:[Explosion] = []
    @Published
    var saucerBullet:Bullet?
    @Published
    var saucer:UFO?
    var hasSaucer = false
    var hasSaucerBullet = false
    var score = 0
    var nextLifeScore = 10000
    var level = 1
    ///For the background beat. This gets slightly faster the more asteroids you hit
    var heartBeat = 0.8
    
    ///New High Score Handling
    @Published
    var letterIndex = 0
    @Published
    var letterArray:[Character] = ["A","A","A"]
    @Published
    var selectedLetter = 0
    
    init() {
#if os(tvOS)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(controllerDidConnect),
            name: .GCControllerDidConnect,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(controllerDidDisconnect),
            name: .GCControllerDidDisconnect,
            object: nil
        )
#endif
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
            ///Saucer
            if !hasSaucer {
                addSaucer()
            } else {
                moveSaucer()
                if !hasSaucerBullet {
                    fireSaucer()
                }
            }
            if hasSaucerBullet {
                moveSaucerBullet()
            }
            /// Check level complete
            checkAsteroidsKilled()
            
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
    
    func startNewGame(){
        score = 0 /// Set to 9500 odd to test extra lives....
        lives = 3
        level = 1
        shipAngle = 270.0
        hasSaucer = false
        startGame()
    }
    
    func startGame() {
        shipLeft = false
        shipRight = false
        gameState = .getready
        heartBeat = 0.8
        /// Get shipPos from a geometry reader in the GameView. This is then set in the .onAppear
        shipPos = shipStartPos
        asteroidArray.removeAll()
        addAsteroids()
        shipTrajectoryAngle = 0.0
        shipVelocity = CGPoint()
        shipAcceleration = CGPoint()
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
        saucer = nil
        hasSaucer = false
        bulletArray.removeAll()
        startGame()
    }
    
    func deadShip(){
        ///Ooops we've been hit!
        ///Ship is now displayed as 3 different Vectors that can move their own way...
        shipExpA = ShipExplodingStruc(position: shipPos, points: sizedExpPointsA,angle: shipAngle)
        shipExpB = ShipExplodingStruc(position: shipPos, points: sizedExpPointsB,angle: adjustAngle(initialAngle: shipAngle, adjustment: 90))
        shipExpC = ShipExplodingStruc(position: shipPos, points: sizedExpPointsC,angle: adjustAngle(initialAngle: shipAngle, adjustment: -90))
        shipExploding = true
        soundFX.bigHitSound()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            hasSaucerBullet = false
            saucerBullet = nil
            hasSaucer = false
            saucer = nil
            shipExploding = false
            lives -= 1
            
            if lives > 0 {
                gameState = .getready
                shipPos = shipStartPos
                shipTrajectoryAngle = 0.0
                shipVelocity = CGPoint()
                shipAcceleration = CGPoint()
                shipThrust = 1.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                    gameState = .playing
                    startHeartBeat()
                }
            } else {
                ///Game over sunshine!
                ///If it's a new hi score then make sure everything is set up.
                if hiScores.isNewHiScore(score: score) {
                    letterIndex = 0
                    selectedLetter = 0
                    letterArray = ["A","A","A"]
                    gameState = .highscore
                } else {
                    lives = 3
                    level = 1
                    gameState = .ended
                }
            }
        }
    }
    
    ///Check our ship hasn't been hit by an asteroid
    func checkShip() {
        for asteroid in asteroidArray {
            let aSize = asteroid.asteroidType.hitSize()
            if circlesIntersect(center1: asteroid.position, diameter1: aSize, center2: shipPos, diameter2: 10.0) {
                deadShip()
            }
        }
        /// Or even a saucer....
        if hasSaucer {
            if let saucerUW = saucer {
                let aSize = saucerUW.type.hitSize()
                if circlesIntersect(center1: saucerUW.position, diameter1: aSize, center2: shipPos, diameter2: 10.0) {
                    deadShip()
                    explosionArray.append(Explosion(position: saucerUW.position, rotation: 180.0))
                    saucer = nil
                    hasSaucer = false
                    hasSaucerBullet = false
                }
            }
        }
        /// or been shot by a saucer
        if hasSaucerBullet {
            if isPointWithinCircle(center: shipPos, diameter: 10.0, point: saucerBullet!.position) {
                deadShip()
                hasSaucerBullet = false
                saucerBullet = nil
            }
        }
    }
    
    /// If we have no asteroids left then it's next level. We give a short pause for sanity.
    func checkAsteroidsKilled() {
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
            asteroidArray.append(Asteroid(position: randomAsteroidPoint(), angle: randomAsteroidAngle(), velocity: 1.0, type: .large,shape: randomAsteroidShape()))
        }
    }
    
    /// Does what it says on the tin.
    func randomAsteroidAngle() -> Double {
        return Double.random(in: 0..<360)
    }
    
    /// Make sure the asteroid position isn't on the ship though
    /// So we have an exclusion zone in the center.
    func randomAsteroidPoint() -> CGPoint {
        let screenWidth = gameSize.width
        let screenHeight = gameSize.height
        let centerX = screenWidth / 2
        let centerY = screenHeight / 2

        let exclusionRadius: CGFloat = 100
        
        var x: CGFloat
        var y: CGFloat
        
        repeat {
            x = CGFloat.random(in: 0..<screenWidth)
            y = CGFloat.random(in: 100..<(screenHeight - 100))
        } while (pow(x - centerX, 2) + pow(y - centerY, 2)) <= pow(exclusionRadius, 2)
        
        return CGPoint(x: x, y: y)
    }
    
    /// Does what it says on the tin.
    func randomAsteroidShape() -> AsteroidShape {
        let shapes: [AsteroidShape] = [.ShapeA, .ShapeB, .ShapeC, .ShapeD]
        return shapes.randomElement()!
    }
    
    ///Called from the player hitting thrust
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
        #if os(iOS)
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
        #endif
    }
    /// We do this every frame
    func moveShip(){
        shipPos.x += shipVelocity.x * 0.6
        shipPos.y += shipVelocity.y * 0.6
        shipVelocity.x += shipAcceleration.x * 0.6
        shipVelocity.y += shipAcceleration.y * 0.6
        shipAcceleration = CGPoint()
        if shipPos.x < -widthPlus {
            shipPos.x = gameSize.width + widthPlus
        }
        else if shipPos.x > gameSize.width + widthPlus {
            shipPos.x = -widthPlus
        }
        else if shipPos.y < -heightPlus {
            shipPos.y = gameSize.height + heightPlus
        }
        else if shipPos.y > gameSize.height + heightPlus {
            shipPos.y = -heightPlus
        }
    }
    
    /// Move the dead bits of the ship
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
#if os(iOS)
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
        #endif
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
    
    ///Hyperspace handling. If yer gonna die, this may work....
    func hyperSpace() {
        shipPos = CGPoint(x: Double.random(in: widthPlus...gameSize.width - widthPlus), y: Double.random(in: heightPlus...gameSize.height - heightPlus))
    }
    
    func moveBullet(){
        if bulletArray.count > 0 {
            ///Remove any bullets that have gone out the screen
            var baIndexSet:IndexSet = []
            for (index,_) in bulletArray.enumerated(){
                if bulletArray[index].position.x < 0 || bulletArray[index].position.x > gameSize.width || bulletArray[index].position.y < 0 || bulletArray[index].position.y > gameSize.height {
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
    
    func moveSaucerBullet() {
        if let saucerBulletUR = saucerBullet {
            saucerBullet?.position = moveAsset(from: saucerBulletUR.position, atAngle: saucerBulletUR.angle, withDistance: saucerBulletUR.velocity)
            ///Saucer bullet off screen.
            if saucerBulletUR.position.x < 0 || saucerBulletUR.position.x > gameSize.width || saucerBulletUR.position.y < 0 || saucerBulletUR.position.y > gameSize.height {
                saucerBullet = nil
                hasSaucerBullet = false
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
                ///Check bullets hitting saucers
                if hasSaucer {
                    if isPointWithinCircle(center: saucer!.position, diameter: (saucer?.type.hitSize())!, point: bullet.position) {
                        baIndexSet.insert(bulIndex)
                        addScore(newScore:(saucer?.type.scores())!)
                        explosionArray.append(Explosion(position: saucer!.position, rotation: 180.0))
                        saucer = nil
                        hasSaucer = false
#if os(iOS)
                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                        generator.impactOccurred()
                        #endif
                        soundFX.bigHitSound()
                    }
                }
            }
            
            bulletArray.remove(atOffsets: baIndexSet)
            for aIndex in astIndexSet {
                if asteroidArray.indices.contains(aIndex)  {
                    let astHit = asteroidArray[aIndex]
                    ///Update Score and add explosion shrapnel and remove the asteroid
                    addScore(newScore:astHit.asteroidType.scores())
                    heartBeat -= 0.01
                    explosionArray.append(Explosion(position: astHit.position, rotation: astHit.rotation))
                    asteroidArray.remove(at: aIndex)
                    /// Bit of haptic feedback helps
#if os(iOS)
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    #endif
                    if astHit.asteroidType == .large {
                        soundFX.bigHitSound()
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAsteroidAngle(), velocity: 1.2, type: .medium,shape: astHit.asteroidShape))
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAsteroidAngle(), velocity: 1.2, type: .medium,shape: astHit.asteroidShape))
                        
                    } else if astHit.asteroidType == .medium {
                        soundFX.mediumHitSound()
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAsteroidAngle(), velocity: 1.5, type: .small,shape: astHit.asteroidShape))
                        asteroidArray.append(Asteroid(position: astHit.position, angle: randomAsteroidAngle(), velocity: 1.5, type: .small,shape: astHit.asteroidShape))
                        
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
                if asteroidArray[index].position.x < -widthAsteroidPlus {
                    asteroidArray[index].position.x = gameSize.width + widthAsteroidPlus
                }
                if asteroidArray[index].position.x > gameSize.width + widthAsteroidPlus {
                    asteroidArray[index].position.x = -widthAsteroidPlus
                }
                if asteroidArray[index].position.y < -heightAsteroidPlus {
                    asteroidArray[index].position.y = gameSize.height + heightAsteroidPlus
                }
                if asteroidArray[index].position.y > gameSize.height + heightAsteroidPlus {
                    asteroidArray[index].position.y = -heightAsteroidPlus
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
    
    ///Add to the score
    func addScore(newScore:Int) {
        score += newScore
        ///Extra life every 10000 points
        if score >= nextLifeScore {
            lives += 1
            nextLifeScore += 10000
            soundFX.extraShipSound()
        }
    }
}
