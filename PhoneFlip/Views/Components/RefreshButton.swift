//
//  RefreshButton.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/15/24.
//

import Foundation
import SwiftUI

struct RefreshButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.clockwise")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}
