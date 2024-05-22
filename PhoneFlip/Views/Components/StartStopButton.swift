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
    var startGameAction: () -> Void //functions as a parameters
    var endGameAction: () -> Void
    
    var body: some View {
        Button(action: {
            if isRunning {
                endGameAction() //this maps the button to endGame if its running and you click it again
            } else {
                startGameAction()
            }
        }) {
            Text(isRunning ? "Stop" : "Start") //styled button that is different colors depending on whether its running or not
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

