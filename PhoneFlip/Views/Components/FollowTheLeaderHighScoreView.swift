//
//  FollowTheLeaderHighScoreView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 5/31/24.
//

import Foundation
import SwiftUI

struct FollowTheLeaderHighScoreView: View {
    @Binding var highScore: HighScores
    
    var body: some View {
        HStack{
            Spacer()
            Text("Longest Streak: \(highScore.followTheLeaderHighScore)")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 5)
            Spacer()
        }
        .animation(.easeInOut(duration: 0.3), value: highScore.followTheLeaderHighScore)
    }
}
