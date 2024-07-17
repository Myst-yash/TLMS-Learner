//
//  Change Password.swift
//  TLMS-learner
//
//  Created by Divyansh Kaushik on 17/07/24.
//

import SwiftUI
struct ChangePassword: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword : String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack{
            PNGImageView(imageName: "Waves", width: 394, height: 194)
                .padding(.top,425)
                VStack {
                    CustomSecureField(placeholder: "Current Password", text: $currentPassword)
                    CustomSecureField(placeholder: "New Password", text: $newPassword)
                    CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                    Button(action: {}){
                        Text("Submit")
                    }   .frame(width: 338, height: 51)
                        .background(Color("color 2")) // You can change the color as needed
                        .foregroundColor(.white) // Text color
                        .cornerRadius(10) // Optional: to make corners rounded
                        .font(.custom("Poppins-Medium", size: 17.0))
                        .fontWeight(.semibold)
                        .padding(.vertical)

                }
                .padding(.bottom,300)
                .alert(isPresented: $showAlert) 
            {
                    Alert(title: Text("Password Change"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationBarTitle("Change Password", displayMode: .large)
                .ignoresSafeArea()
        }
        }
}
#Preview{
    ChangePassword()
}
