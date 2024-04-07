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
                    }
                    // UI for classic mode
                } else if viewModel.currentMode == .timed {
                    Text("Welcome to the timed View")
                    // UI for timed mode
                } else if viewModel.currentMode == .freestyle {
                    Text("Welcome to the freestyle View")
                    // UI for freestyle mode
                }
            }
        }
}


