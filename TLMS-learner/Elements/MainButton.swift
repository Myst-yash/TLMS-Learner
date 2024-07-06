//
//  Button.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 04/07/24.
//

import SwiftUI
struct CustomButton: View {
    var label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(width: 354, height: 51)
//                .background(Color(hex: "#6C5DD4")) // You can change the color as needed
                .background(Color(.blue))
                .foregroundColor(.white) // Text color
                .cornerRadius(10) // Optional: to make corners rounded
                .font(.custom("Poppins-Medium", size: 17.0))
                .fontWeight(.semibold)
        }
    }
}

