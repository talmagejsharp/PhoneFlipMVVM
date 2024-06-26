//
//  HomeViewModel.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedGameMode: GameMode?
    @Published var gameModes: [GameMode] = [.classic, .followTheLeader, .freestyle]
    @Published var flips: [Flip] = Flip.allCases.filter { $0 != .notSet }
    
    func selectGameMode(_ mode: GameMode){
        selectedGameMode = mode
    }
}
