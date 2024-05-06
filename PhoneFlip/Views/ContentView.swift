import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var showingInfoView = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background with a slight gradient and a texture
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.green.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        Image("backgroundTexture") // Replace with your own texture image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                
                VStack {
                    Spacer()
                    
                    // Animated title
                    Text("PhoneFlip")
                        .font(Font.custom("Honk-Regular", size: 50)) // Replace with your custom font
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .scaleEffect(1.1)
                        .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                         

                    Spacer()
                    
                    // Animated Game Mode Buttons
                    ForEach(viewModel.gameModes.indices, id: \.self) { index in
                        GameModeButton(mode: viewModel.gameModes[index])
                    }
                    
                    Spacer()
                    
                    // Information button that pulses
                    Button(action: {
                        // Action for information
                        showingInfoView.toggle()
                    }) {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.large)
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Circle().fill(Color.green).shadow(radius: 10))
                            .scaleEffect(showingInfoView ? 1.2 : 1.0)
                            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                    }
                    .padding(.bottom)
                    .sheet(isPresented: $showingInfoView) {
                                                InfoView(viewModel: viewModel)
                                            }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameModeButton: View {
    let mode: GameMode
    var body: some View {
        NavigationLink(destination: GameView(mode: mode)) {
            Text(mode.displayName)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(ButtonBackground())
                .cornerRadius(10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}

struct ButtonBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                Path { path in
                    for x in stride(from: 0, to: geometry.size.width, by: 5) {
                        for y in stride(from: 0, to: geometry.size.height, by: 5) {
                            if Bool.random() {
                                path.addRect(CGRect(x: x, y: y, width: 2, height: 2))
                            }
                        }
                    }
                }
                .fill(Color.white.opacity(0.3))
            }
        }
    }
}

// Add this preview to support your SwiftUI Previews
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

// Make sure to include actual font and texture file names
