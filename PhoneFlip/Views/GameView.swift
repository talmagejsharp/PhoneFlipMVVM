//
//  GameView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import Foundation
import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    init(mode: GameMode){
        print("initializing a gameViewModel with type: \(mode.displayName)")
        viewModel = GameViewModel(currentMode: mode)
    }
    
    var body: some View {
            VStack {
                if viewModel.currentMode == .classic {
                    VStack{
//                        Text("Welcome to the Classic View")
                        TimerView(viewModel: self.viewModel)
                        Spacer()
                        LastFlipView(lastFlip: $viewModel.lastFlip)
                        ScoreView(score: $viewModel.score)
                        Spacer()
                        HStack{
                            StartStopButton(isRunning: $viewModel.isRunning, startGameAction: viewModel.startGame, endGameAction: viewModel.endGame)
                            if !viewModel.isRunning && viewModel.refreshable {
                                RefreshButton(action: viewModel.refreshGame)
                            }
                        }
                        Spacer()
                        //TODO: Make something display your score when it finishes
                    }
                    // UI for classic mode
                } else if viewModel.currentMode == .followTheLeader {
                    Text("Welcome to the Follow The Leader View")
                    Spacer()
                    LastFlipView(lastFlip: $viewModel.nextFlip)
                    Spacer()
                    LastFlipView(lastFlip: $viewModel.lastFlip)
                    Spacer()
                    MatchedView(matched: $viewModel.matched)
                    Spacer()
                    //TODO: Add a Streak Counter? Add Points? A Timer? If it was the wrong flip do we set a new flip?
                    // UI for timed mode
                } else if viewModel.currentMode == .freestyle {
//                    Text("Welcome to the freestyle View")
                    Spacer()
                    LastFlipView(lastFlip: $viewModel.lastFlip)
                    Spacer()
                    // UI for freestyle mode
                }
            }
        }
}


