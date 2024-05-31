//
//  HighScores.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 5/31/24.
//

import Foundation

struct HighScores {
    var classicHighScore: Int
    var followTheLeaderHighScore: Int
    
    mutating func compareClassicHighScore(newScore: Int) -> Bool {
        if newScore > classicHighScore {
            classicHighScore = newScore
            saveHighScores()
            return true
        } else {
            return false
        }
    }
    
    mutating func compareFollowTheLeaderHighScore(newScore: Int) -> Bool{
        if newScore > followTheLeaderHighScore {
            followTheLeaderHighScore = newScore
            saveHighScores()
            return true
        } else {
            return false
        }
    }
    
    private func saveHighScores() {
        UserDefaults.standard.set(classicHighScore, forKey: "classicHighScore")
        UserDefaults.standard.set(followTheLeaderHighScore, forKey: "followTheLeaderHighScore")
    }
    
    static func loadHighScores() -> HighScores {
        let classicHighScore = UserDefaults.standard.integer(forKey: "classicHighScore")
        let followTheLeaderHighScore = UserDefaults.standard.integer(forKey: "followTheLeaderHighScore")
        return HighScores(classicHighScore: classicHighScore, followTheLeaderHighScore: followTheLeaderHighScore)
    }
}
