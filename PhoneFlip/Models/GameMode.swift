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
}

