//
//  SoundFX.swift
//  Asteroids
//
//  Created by Jonathan French on 6.08.24.
//

import Foundation
import AVFoundation

final class SoundFX {
    
    private var bigHitAudioPlayer: AVAudioPlayer?
    private var mediumHitAudioPlayer: AVAudioPlayer?
    private var smallHitAudioPlayer: AVAudioPlayer?
    private var shootAudioPlayer: AVAudioPlayer?
    private var saucerBigAudioPlayer: AVAudioPlayer?
    private var saucerSmallAudioPlayer: AVAudioPlayer?
    private var extraShipAudioPlayer: AVAudioPlayer?
    private var thrustAudioPlayer: AVAudioPlayer?
    private var beat1AudioPlayer: AVAudioPlayer?
    private var beat2AudioPlayer: AVAudioPlayer?

    private lazy var fireurl = Bundle.main.url(forResource: "fire", withExtension: "wav")
    private lazy var bigKillurl = Bundle.main.url(forResource: "bangLarge", withExtension: "wav")
    private lazy var mediumKillurl = Bundle.main.url(forResource: "bangMedium", withExtension: "wav")
    private lazy var smallKillurl = Bundle.main.url(forResource: "bangSmall", withExtension: "wav")
    private lazy var extraShipurl = Bundle.main.url(forResource: "extraShip", withExtension: "wav")
    private lazy var smallUFOurl = Bundle.main.url(forResource: "saucerSmall", withExtension: "wav")
    private lazy var bigUFOurl = Bundle.main.url(forResource: "saucerBig", withExtension: "wav")
    private lazy var thrusturl = Bundle.main.url(forResource: "thrust", withExtension: "wav")
    private lazy var beat1url = Bundle.main.url(forResource: "beat1", withExtension: "wav")
    private lazy var beat2url = Bundle.main.url(forResource: "beat2", withExtension: "wav")

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            shootAudioPlayer = try AVAudioPlayer(contentsOf: fireurl!, fileTypeHint: AVFileType.wav.rawValue)
            bigHitAudioPlayer = try AVAudioPlayer(contentsOf: bigKillurl!, fileTypeHint: AVFileType.wav.rawValue)
            mediumHitAudioPlayer = try AVAudioPlayer(contentsOf: mediumKillurl!, fileTypeHint: AVFileType.wav.rawValue)
            smallHitAudioPlayer = try AVAudioPlayer(contentsOf: smallKillurl!, fileTypeHint: AVFileType.wav.rawValue)
            extraShipAudioPlayer = try AVAudioPlayer(contentsOf: extraShipurl!, fileTypeHint: AVFileType.wav.rawValue)
            saucerBigAudioPlayer = try AVAudioPlayer(contentsOf: bigUFOurl!, fileTypeHint: AVFileType.wav.rawValue)
            saucerSmallAudioPlayer = try AVAudioPlayer(contentsOf: smallUFOurl!, fileTypeHint: AVFileType.wav.rawValue)
            thrustAudioPlayer = try AVAudioPlayer(contentsOf: thrusturl!, fileTypeHint: AVFileType.wav.rawValue)
            beat1AudioPlayer = try AVAudioPlayer(contentsOf: beat1url!, fileTypeHint: AVFileType.wav.rawValue)
            beat2AudioPlayer = try AVAudioPlayer(contentsOf: beat2url!, fileTypeHint: AVFileType.wav.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @objc func play(audioPlayer:AVAudioPlayer){
        audioPlayer.play()
    }
        
    func beat1Sound(){
        guard let beat1AudioPlayer = beat1AudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: beat1AudioPlayer)
    }
    
    func beat2Sound(){
        guard let beat2AudioPlayer = beat2AudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: beat2AudioPlayer)
    }
    
    func fireSound(){
        guard let shootAudioPlayer = shootAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: shootAudioPlayer)
    }
    
    func bigHitSound() {
        guard let hitAudioPlayer = bigHitAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: hitAudioPlayer)
    }
    func mediumHitSound() {
        guard let hitAudioPlayer = mediumHitAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: hitAudioPlayer)
    }
    func smallHitSound() {
        guard let hitAudioPlayer = smallHitAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: hitAudioPlayer)
    }

    func extraShipSound() {
        guard let extraShipAudioPlayer = extraShipAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: extraShipAudioPlayer)
    }
    
    func bigUFOSound()
    {
        guard let saucerBigAudioPlayer = saucerBigAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: saucerBigAudioPlayer)
    }
    func smallUFOSound()
    {
        guard let saucerSmallAudioPlayer = saucerSmallAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: saucerSmallAudioPlayer)
    }
    
    func thrustSound()
    {
        guard let thrustAudioPlayer = thrustAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: thrustAudioPlayer)
    }
    
}
