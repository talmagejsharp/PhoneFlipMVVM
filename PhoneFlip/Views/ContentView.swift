//
//  ContentView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("PhoneFlip")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                
                    ForEach(viewModel.gameModes, id: \.self) { mode in
                        NavigationLink(destination: GameView(mode: mode)){
                                Text(mode.displayName)
                                    .font(.title2)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
