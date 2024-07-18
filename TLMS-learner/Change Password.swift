//
//  Change Password.swift
//  TLMS-learner
//
//  Created by Divyansh Kaushik on 17/07/24.
//

import SwiftUI
import FirebaseAuth
struct ChangePassword: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword : String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isPasswordValid: Bool = true
    @State private var doPasswordsMatch: Bool = true
    
    var body: some View {
        ZStack{
            PNGImageView(imageName: "Waves", width: 394, height: 194)
                .padding(.top,425)
                VStack {
                    CustomSecureField(placeholder: "Current Password", text: $currentPassword)
                    
                    
                    CustomSecureField(placeholder: "New Password", text: $newPassword)
                        .onChange(of:newPassword){
                            newValue in isPasswordValid = AuthValidation.shared.validatePassword(password: newValue)
                        }
                      
                    if !isPasswordValid{
                        Text("Enter a Strong password")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.trailing,15)
                    }
                    CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                    
                    if !doPasswordsMatch {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.trailing,15)
                    
                    }
                    Button(action: {
                        changePassword()
                    }) {
                        Text("Submit")
                    } 
                    .frame(width: 338, height: 51)
                    .background(Color("color 2")) // You can change the color as needed
                    .foregroundColor(.white) // Text color
                    .cornerRadius(10) // Optional: to make corners rounded
                    .font(.custom("Poppins-Medium", size: 17.0))
                    .fontWeight(.semibold)
                    .padding(.vertical)

                }
                .padding(.bottom,300)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Password Change"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationBarTitle("Change Password", displayMode: .large)
                .ignoresSafeArea()
        }
    }
    
    
    
    
    func changePassword(){
        guard let user = Auth.auth().currentUser, let email = user.email else{
            alertMessage = "Unable to retrieve user Information."
            showAlert = true
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        user.reauthenticate(with: credential){ result, error in
            if let error = error{
                print("Reauthentication error: \(error.localizedDescription)")
                print("\(currentPassword)")
                alertMessage = "Current password is incorrect."
                showAlert = true
                return
            }
            if !doPasswordsMatch{
                alertMessage = "New passowrd and confirm password do not match."
                showAlert = true
                return
            }
            if !isPasswordValid{
                alertMessage = "Please use atleast 8 lenght password( 1 capital letter, 1 small letter, 1 symbol and 1 Number)"
                showAlert = true
                return
            }
            user.updatePassword(to: newPassword){ error in
                if let error = error{
                    alertMessage = "Error updating password: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                alertMessage = "Password updated successfully"
                showAlert = true
            
            }
            
            
        }
    }
    
    
    
    
    
    
    
}
#Preview{
    ChangePassword()
}
