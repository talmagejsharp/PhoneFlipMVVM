//
//  StartStopButton.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/15/24.
//

import Foundation
import SwiftUI

struct StartStopButton: View {
    @Binding var isRunning: Bool
    var startGameAction: () -> Void
    var endGameAction: () -> Void
    
    var body: some View {
        Button(action: {
            if isRunning {
                endGameAction()
            } else {
                startGameAction()
            }
        }){
            Text(isRunning ? "Stop" : "Start")
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 200) // Set the minimum width to 200 points
                .background(isRunning ? Color.red : Color.blue)
                .cornerRadius(10)
        }
    }
}
