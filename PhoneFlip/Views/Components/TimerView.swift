//
//  TimerView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/14/24.
//

import Foundation
import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        Text(String(format: "%.0f", viewModel.timeLeft)) //simply displays the ViewModel's timeLeft variable
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundColor(.green)
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}
