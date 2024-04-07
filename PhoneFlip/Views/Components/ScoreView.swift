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
    
    var body: some View {
        Text("Score: \(score)")
            .font(.title)
            .padding()
    }
}
