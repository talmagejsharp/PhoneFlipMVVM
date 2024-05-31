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
    
    init(mode: GameMode){ //pass a GameMode class into the initializer
        print("initializing a gameViewModel with type: \(mode.displayName)")
        viewModel = GameViewModel(currentMode: mode) //instantiates a gameViewModel for the current gameMode
    }
    
    var body: some View {
            VStack {
                if viewModel.currentMode == .classic { //specific UI components for .classic mode
                    VStack{
//                        Text("Welcome to the Classic View")
                        TimerView(viewModel: self.viewModel) //creates a TimerView()
                        Spacer()
                        LastFlipView(lastFlip: $viewModel.lastFlip) //displays the viewModel.lastFlip value
                        ScoreView(score: $viewModel.score, isRunning: $viewModel.isRunning)
                        Spacer()
                        HStack{
                            StartStopButton(isRunning: $viewModel.isRunning, startGameAction: viewModel.startGame, endGameAction: viewModel.endGame)
                            if !viewModel.isRunning && viewModel.refreshable { //adds a refresh button if the game is refreshable
                                RefreshButton(action: viewModel.refreshGame)
                            }
                        }
                        Spacer()
                        //TODO: Make something display your score when it finishes
                    }
                    // UI for classic mode
                } else if viewModel.currentMode == .followTheLeader {
//                     Text("Welcome to the Follow The Leader View")
                    Spacer()
                    FollowTheLeaderHighScoreView(highScore: $viewModel.highScores)
                    StreakView(streak: $viewModel.streak)
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


