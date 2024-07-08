import SwiftUI

// Custom TitleLabel struct
struct TitleLabel: View {
    var text: String
    var fontSize: CGFloat = 34 // Default font size

    var body: some View {
        
        Text(text)
            .lineLimit(2)
            .font(.custom("Poppins-Bold", size: 34))
            .foregroundColor(.black)
            .frame(maxWidth: 800, alignment: .leading) // Optional: Full width alignment
            .background(Color.clear) // Optional: Background color
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(0.7)

    }
}
