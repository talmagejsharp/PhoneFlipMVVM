//
//  ContentView.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var showingInfoView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Settings button on the left
                    Button(action: {
                        // Action for settings
                        print("Settings tapped")
                    }) {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)  // Increase the scale of the icon
                            .font(.title)        // Increase the font size of the icon
                            .foregroundColor(.blue)
                    }
                    .padding()

                    Spacer() // Spacer to push the title and buttons apart

                    // Title in the center
                    Text("PhoneFlip")
                        .font(.largeTitle)

                    Spacer() // Another spacer for symmetry

                    // Information button on the right
                    Button(action: {
                        // Action for information
                        showingInfoView = true
                    }) {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.large)  // Increase the scale of the icon
                            .font(.title)        // Increase the font size of the icon
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
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
            .sheet(isPresented: $showingInfoView) {
                            InfoView(viewModel: viewModel)
                        }
        }
    }
}


#Preview {
    ContentView()
}
