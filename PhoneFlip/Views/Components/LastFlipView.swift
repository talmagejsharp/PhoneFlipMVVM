import Foundation
import SwiftUI

struct LastFlipView: View {
    @Binding var lastFlip: Flip
    @State private var animatePop = false

    var body: some View {
        Text(lastFlip.displayName)
            .font(.system(size: 68, weight: .bold, design: .rounded))
            .foregroundColor(.green)
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(10)
            .shadow(radius: 5)
            // Apply the scale effect based on animatePop state
            .scaleEffect(animatePop ? 1.2 : 1.0)
            // Listen for changes on lastFlip
            .onChange(of: lastFlip) { _ in
                animatePopEffect()
            }
    }
    
    // Function to perform the animation
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
