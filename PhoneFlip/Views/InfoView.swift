import SwiftUI

struct InfoView: View {
    enum Tab {
        case gameModes
        case flips
    }
    
    @State private var selectedTab: Tab = .gameModes
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Picker("Select", selection: $selectedTab) {
                Text("GameModes").tag(Tab.gameModes)
                Text("Flips").tag(Tab.flips)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
//            .scaleEffect(1.2) // Increase the scale of the Picker
            // Apply larger font to the text inside the Picker
            .font(.system(size: 32, weight: .bold))

            // The content below the Picker changes depending on the selected tab
            switch selectedTab {
            case .gameModes:
                GameModesView(viewModel: viewModel)
            case .flips:
                FlipsView(viewModel: viewModel)
            }
            
            Spacer() // Pushes everything to the top
        }
        .navigationTitle("Information")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameModesView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
            ScrollView {
                VStack(spacing: 20) { // Provides spacing between each card
                    ForEach(viewModel.gameModes, id: \.self) { mode in
                        VStack(alignment: .leading, spacing: 8) { // Vertical stack for text
                            Text(mode.displayName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 2)

                            Text(mode.description)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .lineLimit(nil) // Allows text to wrap and expand
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                }
                .padding() // Padding around the VStack to inset the content
            }
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Black background for the whole view
        }
}

struct FlipsView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
            ScrollView {
                VStack(spacing: 20) { // Provides spacing between each card
                    ForEach(viewModel.flips, id: \.self) { flip in
                        VStack(alignment: .leading, spacing: 8) { // Vertical stack for text
                            Text(flip.displayName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 2)

                            Text(flip.description)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .lineLimit(nil) // Allows text to wrap and expand
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                }
                .padding() // Padding around the VStack to inset the content
            }
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Black background for the whole view
        }

}
