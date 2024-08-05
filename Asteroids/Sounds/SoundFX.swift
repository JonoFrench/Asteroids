//
//  SoundFX.swift
//  Asteroids
//
//  Created by Jonathan French on 6.08.24.
//

import Foundation
import AVFoundation

final class SoundFX {
    
    var bigHitAudioPlayer: AVAudioPlayer?
    var mediumHitAudioPlayer: AVAudioPlayer?
    var smallHitAudioPlayer: AVAudioPlayer?
    var shootAudioPlayer: AVAudioPlayer?
    var motherAudioPlayer: AVAudioPlayer?
    var baseAudioPlayer: AVAudioPlayer?
    var invaderAudioPlayer: AVAudioPlayer?
    
    lazy var fireurl = Bundle.main.url(forResource: "fire", withExtension: "wav")
    lazy var bigKillurl = Bundle.main.url(forResource: "bangLarge", withExtension: "wav")
    lazy var mediumKillurl = Bundle.main.url(forResource: "bangMedium", withExtension: "wav")
    lazy var smallKillurl = Bundle.main.url(forResource: "bangSmall", withExtension: "wav")
    lazy var explosionurl = Bundle.main.url(forResource: "fire", withExtension: "wav")
    lazy var ufourl = Bundle.main.url(forResource: "fire", withExtension: "wav")
    lazy var invurl = Bundle.main.url(forResource: "fire", withExtension: "wav")
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            shootAudioPlayer = try AVAudioPlayer(contentsOf: fireurl!, fileTypeHint: AVFileType.wav.rawValue)
            bigHitAudioPlayer = try AVAudioPlayer(contentsOf: bigKillurl!, fileTypeHint: AVFileType.wav.rawValue)
            mediumHitAudioPlayer = try AVAudioPlayer(contentsOf: mediumKillurl!, fileTypeHint: AVFileType.wav.rawValue)
            smallHitAudioPlayer = try AVAudioPlayer(contentsOf: smallKillurl!, fileTypeHint: AVFileType.wav.rawValue)
            baseAudioPlayer = try AVAudioPlayer(contentsOf: explosionurl!, fileTypeHint: AVFileType.wav.rawValue)
            motherAudioPlayer = try AVAudioPlayer(contentsOf: ufourl!, fileTypeHint: AVFileType.wav.rawValue)
            invaderAudioPlayer = try AVAudioPlayer(contentsOf: invurl!, fileTypeHint: AVFileType.wav.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @objc func play(audioPlayer:AVAudioPlayer){
        audioPlayer.play()
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

    func baseHitSound() {
        guard let baseAudioPlayer = baseAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: baseAudioPlayer)
    }
    
    func motherSound()
    {
        guard let motherAudioPlayer = motherAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: motherAudioPlayer)
    }
    
    func invaderSound()
    {
        guard let invaderAudioPlayer = invaderAudioPlayer else { return }
        Thread.detachNewThreadSelector(#selector(play), toTarget: self, with: invaderAudioPlayer)
    }
    
}
