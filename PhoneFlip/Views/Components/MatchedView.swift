//
//  MatchedView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 4/10/24.
//

import Foundation
import SwiftUI

struct MatchedView: View {
    @Binding var matched: Bool
        
        var body: some View {
            ZStack {
                Circle()
                    .foregroundColor(matched ? .green : .red)
                    .frame(width: 50, height: 50)
                Image(systemName: matched ? "checkmark" : "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }
        }
}
