//
//  TextLabel.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 05/07/24.
//

import SwiftUI

// Custom TextField struct
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var placeholderOpacity: Double = 0.5 // Default opacity for placeholder

    var body: some View {
        ZStack(alignment: .leading) {
            // Placeholder text
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.gray.opacity(placeholderOpacity))
                    .padding(.leading, 32) // Adjust padding to align with TextField's padding
            }
            // Actual TextField
            TextField("", text: $text)
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
