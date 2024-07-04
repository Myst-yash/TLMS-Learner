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
            ZStack(alignment: .topLeading) {
                
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)

                VStack {
//
                    HStack {
                            Text("Welcome to Svadhyaya")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            Spacer()
                                      }
                                  
                            Spacer()
                            .frame(height: 20)
                
                    
                    Image("laptop")
                    
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .padding()

                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)

                        Button(action: {
//                            print("\(email) : \(password)")
////                            Auth.auth().signIn(withEmail: email, password: password) {
////                                (fire, error) in if let _ = error {
////                                    print("Couldnt log in")
////                        
//                                }
//                                print("You've successfully Logged In!!")
//                            }
//
                            // Perform login action here
                            showAlert = true
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)

                         

                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Don't have an account?")
                            .font(.headline)
                            .foregroundColor(.blue)
//                        NavigationLink(destination: SignupView()) { // Link to signup view
                            Text("Signup")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
//            .alert("Invalid Credentials", isPresented: $showAlert) {
//                Button("OK", role: .cancel) { }
//            } message: {
//                Text("Please check your email and password.")
//            }
        }
    }


#Preview {
    ContentView()
}
