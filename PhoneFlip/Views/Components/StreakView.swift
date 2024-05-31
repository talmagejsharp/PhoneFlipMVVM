//
//  StreakView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 5/31/24.
//

import Foundation
import SwiftUI

struct StreakView: View {
    @Binding var streak: Int
    
    var body: some View {
        HStack{
            Spacer()
            Text("Streak: \(streak)")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 5)
            Spacer()
        }
        .animation(.easeInOut(duration: 0.3), value: streak)
    }
}
