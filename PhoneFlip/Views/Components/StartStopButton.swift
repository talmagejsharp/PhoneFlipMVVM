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
        }) {
            Text(isRunning ? "Stop" : "Start")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 200)
                .background(LinearGradient(gradient: Gradient(colors: [isRunning ? .red : .blue, isRunning ? .orange : .purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

