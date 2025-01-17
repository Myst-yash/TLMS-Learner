//
//  ForgetPassword.swift
//  TLMS-learner
//
//  Created by Abcom on 09/07/24.
//


import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var isEmailValid = false
    @State private var showAlert = false
    @State private var navigateToHome = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack(alignment: .bottom){
            PNGImageView(imageName: "Waves", width: 394, height: 194)
            
            VStack(alignment: .center) {
                CustomTextField(placeholder: "Email", text: $email)
                    .onChange(of: email) { _, newVal in
                        isEmailValid = AuthValidation.shared.validateEmail(email: newVal)
                        print(isEmailValid)
                        
                    }
                HStack {
                    
                    if !isEmailValid && email != ""{
                        Text("Enter a valid email address")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .padding(.trailing, 35)
                    } else {
                        Text("Enter a valid email address")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(.trailing, 15)
                    }
                }
                
                CustomButton(label: "Send E-Mail", action: {
                    if !isEmailValid {
                        alertMessage = "Please enter the field correctly"
                        showAlert = true
                    } else {
                        passwordReset()
                    }
                })
                Spacer()
            }
            .padding(.top, 180)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                })
        }
        .navigationBarTitle("Forgot password", displayMode: .large)
        .ignoresSafeArea()
        
    }
    
    func passwordReset() {
        Auth.auth().sendPasswordReset(withEmail: email) {
            (error) in
            if let _ = error {
                print("Error. Couldn't mail the link.")
                alertMessage = "Failed to send the link"
                showAlert = true
            }
            print("Sent Mail for Changing Password")
            alertMessage = "Sucessfully sent the link to your registred E-Mail."
            showAlert = true
        }
    }
    
    func backToHome() {
        
    }
}

#Preview {
    NavigationView {
        ForgotPasswordView()
    }
}
