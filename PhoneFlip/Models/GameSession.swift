//
//  GameSession.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import Foundation
import Combine

class GameSession: ObservableObject {
    @Published var lastFlip: Flip = .notSet
    @Published var score: Int
    @Published var isRunning: Bool
    @Published var refreshable = false
    @Published var timeLeft: TimeInterval = 0
    var defaultTimeLeft = 15.00
    
    
    init(lastFlip: Flip, score: Int, timeLeft: TimeInterval, isRunning: Bool, defaultTimeLeft: Double = 15.00, refreshable: Bool = false) {
        self.lastFlip = lastFlip
        self.score = score
        self.timeLeft = timeLeft
        self.isRunning = isRunning
        self.defaultTimeLeft = defaultTimeLeft
        self.refreshable = refreshable
    }
 
    func setFlip(with newFlip: Flip){
        lastFlip = newFlip
    }
}
