//
//  ContentView.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 03/07/24.
//


import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.topLeading) {
                Color(UIColor(hex: "#FFFFFF")!)
                    .edgesIgnoringSafeArea(.all)
                Image("Waves")
                    .resizable()
                    .scaledToFit()
                    .position(x:197,y:735)// Extend to ignore safe area insets
                
                VStack {
                    HStack {
                        
                    Text("Welcome to Svadhyaya")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        
                    Spacer()
                }
            
                    
                    Image("laptop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .padding(.bottom, 20)
                    
                    // Login Form
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .padding()                                                     .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                          
                            
                        
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .cornerRadius(8)                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )

                            .padding(.horizontal)
                        
                        HStack {
                                                    Spacer()
                                                    Button("Forgot Password") {
                                                        // Implement forgot password logic here
                                                    }
                                                    .foregroundColor(.blue)
                                                 
                                                    .padding(.horizontal)
                                                    .font(.system(size: 15, weight: .bold, design: .default))
                            
                                                }
                                                
                        
                        Button(action: {
                            // Perform login action here
                            showAlert = true
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor(named: "PrimaryColor")!))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Login Action"), message: Text("Perform your login action here."), dismissButton: .default(Text("OK")))
                        }
                        
                        // Sign Up Option
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 15, weight: .regular, design: .default))
                            NavigationLink(destination: SignupView()) {
                                Text("Sign up")
                                    .font(.system(size: 15, weight: .bold, design: .default))
                                    .fontWeight(.bold)
                            }
                        }
                        
                        // Social Login Buttons
                        HStack(spacing: 20) {
                            Button(action: {
                                // Perform Google login action
                                print("Google login")
                            }) {
                                Image("Google")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                  
                                    .cornerRadius(100)
                            }
                            
                            Button(action: {
                                // Perform Apple login action
                                print("Apple login")
                            }) {
                                Image("Apple")
                                    .resizable()
                                    .frame(width: 50, height:50 )
                                   
                                    .cornerRadius(100)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .navigationBarHidden(true)
                }
            }
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
