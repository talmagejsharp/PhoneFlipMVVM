//
//  GameModels.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import Foundation

enum GameMode: String, CaseIterable, Identifiable {
    case classic, followTheLeader, freestyle
    
    var id: Self { self }
    
    var displayName: String {
        switch self {
        case .classic: return "Classic"
        case .followTheLeader: return "Follow The Leader"
        case .freestyle: return "Freestyle"
        }
    }
    
    var description: String {
        switch self {
        case .classic: return "Classic is a game mode with a 15 second timer. You are scored based on the flips you do within that time limit. What's the highest score you can get in 15 seconds?"
        case .followTheLeader: return "Follow The Leader is a game mode where you are challenged to match the flip named by the computer. How many can you get in a row?"
        case .freestyle: return "Freestyle is a game mode that diplays the flips you do. Its a great way to practice your skills."
        }
    }
}

