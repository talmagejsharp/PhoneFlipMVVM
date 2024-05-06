//
//  ScoreView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/15/24.
//

import Foundation
import SwiftUI

struct ScoreView: View {
    @Binding var score: Int
    @Binding var isRunning: Bool
    @State private var animatePop = false
    
    var body: some View {
        Text("Score: \(score)")
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .foregroundColor(.green)
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(10)
            .shadow(radius: 5)
            .scaleEffect(animatePop ? 1.2 : 1.0)
            // Listen for changes on lastFlip
            .onChange(of: score) { _ in
                animatePopEffect()
            }
            .animation(isRunning ? nil : Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animatePop)
    }
    
    private func animatePopEffect() {
        // Reset the state to ensure the animation can be triggered again
        self.animatePop = false
        
        // Dispatch needed to allow the state reset to be processed before triggering the animation
        DispatchQueue.main.async {
            // Trigger the pop animation
            withAnimation(.easeInOut(duration: 0.2)) {
                self.animatePop = true
            }
            
            // Optionally, reset back after a short delay to create a "pop" effect
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.animatePop = false
                }
            }
        }
    }
}
