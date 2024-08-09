//
//  ManagerScoreExt.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import Foundation

extension GameManager {
    ///Hi Score handling from the ControlsView

    func addLetter(){
        letterArray[letterIndex] = hiScores.highScoreLetters[selectedLetter]
    }
    
    func letterUp() {
        selectedLetter += 1
        if selectedLetter == 26 {
            selectedLetter = 0
        }
        letterArray[letterIndex] = hiScores.highScoreLetters[selectedLetter]
    }
    
    func letterDown() {
        selectedLetter -= 1
        if selectedLetter == -1 {
            selectedLetter = 25
        }
        letterArray[letterIndex] = hiScores.highScoreLetters[selectedLetter]
    }
    
    func nextLetter() {
        letterIndex += 1
        selectedLetter = 0
        /// Final letter and store it
        if letterIndex == 3 {
            hiScores.addScores(score: score, initials: String(letterArray))
            hiScores.getScores()
            gameState = .intro
        }
    }
}
