import SwiftUI
struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            // Actual SecureField
            SecureField(placeholder, text: $text)
                .padding()
                .frame(width: 335, height: 55)
                .background(Color.white) // Background color
                .cornerRadius(12) // Rounded corners
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1) // Border
                )
                .padding(.horizontal) // Optional: Add padding on horizontal sides
        }
    }
}
