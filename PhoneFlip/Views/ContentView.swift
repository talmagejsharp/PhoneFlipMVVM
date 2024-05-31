import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel() // instantiate a HomeViewModel to manage this view
    @State private var showingInfoView = false //bool to show info sheet
    @State private var scaleUp = false
    @State private var scaleInfo = false

    var body: some View {
        NavigationView { //In order for navigation links to work they must be inside a NavigationView
            ZStack { //Stacks views on top of eachother
                // Background with a slight gradient and a texture
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.green.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    // Animated title
                    Text("PhoneFlip")
                        .font(Font.custom("Honk-Regular", size: 50)) // Replace with your custom font
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .scaleEffect(scaleUp ? 1.1 : 1.0)
                        .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                    scaleUp.toggle()
                                }
                            }
                         

                    Spacer()
                    
                    // Loops through game modes and creates a button for each
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
                            .scaleEffect(scaleInfo ? 1.2 : 1.0)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                    scaleInfo.toggle()
                                }
                            }
                            
                    }
                    .padding(.bottom)
                    .sheet(isPresented: $showingInfoView) { //if $showingInfoView then it will display the infoView as a popup sheet
                                                InfoView(viewModel: viewModel)
                                            }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameModeButton: View { //simple view for a gamebutton
    let mode: GameMode
    var body: some View {
        NavigationLink(destination: GameView(mode: mode)) { //just a button with styling
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

struct ButtonBackground: View { //a simple view that makes a random background
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
                                path.addRect(CGRect(x: x, y: y, width: 2, height: 2)) //adds random white rectangles accross the button
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
