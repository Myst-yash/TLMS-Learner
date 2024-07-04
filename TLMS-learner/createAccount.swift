//
//  createAccount.swift
//  TLMS-learner
//
//  Created by Abid Ali    on 04/07/24.
//



import Foundation
import SwiftUI

struct AccountView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                Image("Waves").resizable().scaledToFit().position(x: 196 , y: 735)
                
                VStack {
                    Text("Welcome to Svadhyaya")
                        .fontWeight(.bold)
                        .font(.custom("Poppins", size: 40))
                        .padding(.trailing,95)
                        .padding(.top, -20)
                    
                    Image("laptop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 214, height: 165)
                        .padding(.top, 10)
                    
                    Text("Create Account")
                        .fontWeight(.semibold)
                        .font(.custom("Poppins", size: 24))
                        .padding(.top, 5)
                    
                    VStack(spacing: 20) {
                        TextField("Full Name", text: $name)
                            .padding()
                            .frame(width: 320, height: 38)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "E0E0E0"), lineWidth: 1)
                            )
                            .font(.custom("Poppins-Regular", size: 18)).padding(.top, -10)

                        TextField("Email", text: $email)
                            .padding()
                            .frame(width: 320, height: 38)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "E0E0E0"), lineWidth: 1)
                            )
                            .font(.custom("Poppins-Regular", size: 18)).padding(.top, -10)

                        TextField("Password", text: $password)
                            .padding()
                            .frame(width: 320, height: 38)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "E0E0E0"), lineWidth: 1)
                            )
                            .font(.custom("Poppins-Regular", size: 18)).padding(.top, -10)
                    }
                    .padding(.top, 20)
                    
                    Button(action: {
                        // Action when button is tapped
                        // Add your action here
                    }) {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 335, height: 51)
                            .background(Color(hex: "6C5DD4"))
                            .cornerRadius(12)
                            .padding(.top, 20)
                    }
                    
                    Button(action: {
                        // Action when "Already have an account" is tapped
                        // Add your action here
                    }) {
                        Text("Already have an account?")
                            .foregroundColor(Color(hex: "007AFF"))
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.top, 20)
                    }
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            // Action when the circle button is tapped
                            // Add your action here
                        }) {
                            Image("googles") // Replace with your image name
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(.white) // Adjust the color of the image
                                .background(
                                    Circle()
                                        .fill(Color(hex: "F0EFFB")) // Background color of the circle
                                        .frame(width: 50, height: 50)
                                ).padding(.trailing, 20)
                        }
                        
                        Button(action: {
                            // Action when the circle button is tapped
                            // Add your action here
                        }) {
                            Image("apples") // Replace with your image name
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(.white) // Adjust the color of the image
                                .background(
                                    Circle()
                                        .fill(Color(hex: "F0EFFB")) // Background color of the circle
                                        .frame(width: 50, height: 50)
                                ).padding(.trailing, -5)
                        }
                    }
                    .padding(.top, 30)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    AccountView()
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
