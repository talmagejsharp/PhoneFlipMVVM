import SwiftUI

struct MatchedView: View {
    @Binding var matched: MatchState
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(backgroundColor)
                .frame(width: 80, height: 80)
                .cornerRadius(8) // Adjust corner radius for a slightly rounded square
            Image(systemName: iconName)
                .foregroundColor(.white)
                .font(.system(size: 32)) // Increase the font size for a bigger icon
        }
        .animation(.easeInOut(duration: 0.3), value: matched) // Animate on matched state change
    }
    
    private var backgroundColor: Color {
        switch matched {
        case .notSet:
            return .gray
        case .matched:
            return .green
        case .notMatched:
            return .red
        }
    }
    
    private var iconName: String {
        switch matched {
        case .notSet:
            return "questionmark"
        case .matched:
            return "checkmark"
        case .notMatched:
            return "xmark"
        }
    }
}
