//
//  ContentView.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 03/07/24.
//


import SwiftUI
import FirebaseAuth
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.topLeading) {
                Color("#FFFFFF")
                    .edgesIgnoringSafeArea(.all)
           
                    PNGImageView(imageName: "Waves", width: 394, height: 194)
                        .position(x:195,y:735)// Extend to ignore safe area insets
                
                
                VStack(spacing: 20) {
                    
                        
                    TitleLabel(text: "Welcome To \n Swadhyay")
                    .font(.custom("Poppins-Bold", size: 40))

            
                    PNGImageView(imageName: "laptop", width: 214, height: 166)
                    
                    
                    // Login Form
                    VStack(spacing: 20) {
                      CustomTextField(placeholder: "Email", text: $email)
                          
                            

                        
                     CustomSecureField(placeholder: "Password", text: $password)
                        
                        HStack {
                                                    Spacer()
                                                    Button("Forgot Password?") {
                                                        // Implement forgot password logic here
                                                    }
                                                    .foregroundColor(.blue)
                                                 
                                                    .padding(.horizontal)
                                                    .font(.system(size: 15, weight: .bold, design: .default))
                                                    .padding(.trailing ,20)
                            
                                                }
                        
                        CustomButton(label: "Login"){
                            print("login successfully")
                        }
                       
                        
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Login Action"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        // Sign Up Option
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 15, weight: .regular, design: .default))
                            NavigationLink(destination: AccountView()) {
                                Text("SignUp")
                                    .font(.system(size: 15, weight: .bold, design: .default))
                                    .fontWeight(.bold)
//                                CustomButton(label: "SignUp", action: {})
                            }
                        }
                        
                        // Social Login Buttons
                        HStack(spacing: 20) {
                            Button(action: {
                                // Perform Apple login action
                                print("Google login")
                            }) {
                                PNGImageView(imageName: "Google", width: 50, height: 50)
                            }
                            
                            Button(action: {
                                // Perform Apple login action
                                print("Apple login")
                            }) {
                                PNGImageView(imageName: "Apple", width: 50, height: 50)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .navigationBarHidden(true)
                }
                .padding(.top, 40)
            }
        }
    }
    
    func loginUser(){
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, err in
            if let err = err{
                alertMessage = err.localizedDescription
                showAlert = true
                print("not logged in")
                return
            }
            alertMessage = "you've logged in"
            showAlert = true
            print("logged in")
        }
    }
}

struct SignupView: View {
    var body: some View {
        Text("Signup View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
