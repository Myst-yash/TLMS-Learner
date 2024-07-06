import SwiftUI

// Custom TitleLabel struct
struct TitleLabel: View {
    var text: String
    var fontSize: CGFloat = 34 // Default font size

    var body: some View {
        
        Text(text)
            .padding(.bottom, 2)
            .padding(.trailing, 10)
            .font(.custom("Poppins_Bold", size: 40))
            .foregroundColor(.black)
            .frame(maxWidth: 350, alignment: .leading) // Optional: Full width alignment
            .background(Color.clear) // Optional: Background color
            .padding(.leading, 0)
//            .padding(.top, 20)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
