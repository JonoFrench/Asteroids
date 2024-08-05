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

class GameManager: ObservableObject {
    
    var soundFX:SoundFX = SoundFX()
    @Published
    var lives = 3
    @Published
    var shipAngle = 0.0
    @Published
    var shipTrajectoryAngle = 0.0
    var shipSpeed = 2.0
    var shipLeft = false
    var shipRight = false
    var shipMoving = false
    var shipThrust = false
    @Published
    var shipPos = CGPoint(x: 100.0, y: 100.0)
    @Published
    var bulletArray:[Bullet] = []
    @Published
    var asteroidArray:[Asteroid] = []
    
    
    init() {
        print("init GameManager")
        shipPos = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 2) - 150)
        asteroidArray.append(Asteroid(position: CGPoint(x: 200, y: 200), angle: 10, velocity: 1.0, type: .large,shape: .ShapeA))
        asteroidArray.append(Asteroid(position: CGPoint(x: 200, y: 300), angle: 100.0, velocity: 1.0, type: .large,shape: .ShapeB))
        asteroidArray.append(Asteroid(position: CGPoint(x: 200, y: 300), angle: 190.0, velocity: 1.0, type: .large,shape: .ShapeC))
        asteroidArray.append(Asteroid(position: CGPoint(x: 300, y: 200), angle: 280.0, velocity: 1.0, type: .large,shape: .ShapeD))
        ///Here we go, lets have a nice DisplayLink to update our model with the screen refresh.
        let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(refreshModel))
        displayLink.add(to: .main, forMode:.common)
        
    }
    
    @objc func refreshModel() {
        
        if shipLeft {
            rotateShipLeft()
        }
        if shipRight {
            rotateShipRight()
        }
        if shipMoving {
            shipPos = moveAsset(from: shipPos, atAngle: shipTrajectoryAngle, withDistance: shipSpeed)
        }
        if bulletArray.count > 0 {
            moveBullet()
        }
        
        moveAsteroids()
        
        checkBullets()
    }
    
    func startMovingShip() {
        shipTrajectoryAngle = shipAngle
        shipMoving = true
    }
    
    func stopMovingShip(){
        shipMoving = false
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
                    //print("remove Bullet")
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
                let astHit = asteroidArray[aIndex]
                asteroidArray.remove(at: aIndex)
                if astHit.asteroidType == .large {
                    soundFX.bigHitSound()
                    asteroidArray.append(Asteroid(position: astHit.position, angle: -astHit.angle, velocity: 1.0, type: .medium,shape: astHit.asteroidShape))
                    asteroidArray.append(Asteroid(position: astHit.position, angle: astHit.angle, velocity: 1.0, type: .medium,shape: astHit.asteroidShape))
                    
                } else if astHit.asteroidType == .medium {
                    soundFX.mediumHitSound()
                    asteroidArray.append(Asteroid(position: astHit.position, angle: -astHit.angle, velocity: 1.0, type: .small,shape: astHit.asteroidShape))
                    asteroidArray.append(Asteroid(position: astHit.position, angle: astHit.angle, velocity: 1.0, type: .small,shape: astHit.asteroidShape))
                    
                } else {
                    soundFX.smallHitSound()
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
                    //print("Asteroid x < 0")
                }
                if asteroidArray[index].position.x > UIScreen.main.bounds.width + 20 {
                    asteroidArray[index].position.x = -20
                    //print("Asteroid x > width")
                }
                
                if asteroidArray[index].position.y < -20 {
                    asteroidArray[index].position.y = UIScreen.main.bounds.height - 300
                    //print("Asteroid y < 0")
                }
                
                if asteroidArray[index].position.y > UIScreen.main.bounds.height - 300 {
                    // print("Asteroid y > height at \(asteroidArray[index].position.y)")
                    asteroidArray[index].position.y = -20
                    //print("Asteroid y > height")
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
