//
//  GameModels.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import Foundation

enum GameMode: String, CaseIterable, Identifiable {
    case classic, timed, freestyle
    
    var id: Self { self }
    
    var displayName: String {
        switch self {
        case .classic: return "Classic"
        case .timed: return "Timed"
        case .freestyle: return "Freestyle"
        }
    }
}

