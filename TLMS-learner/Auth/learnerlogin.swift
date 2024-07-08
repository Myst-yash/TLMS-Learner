//
//  ContentView.swift
//  TLMS-learner
//
//  Created by Ishika  on 03/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuth
struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var login = false
    @State private var isEmailValid:Bool = true
    
    var body: some View {
        NavigationView{
            ZStack(alignment:.bottom) {
                PNGImageView(imageName: "Waves", width: 394, height: 194)
                VStack(alignment: .center, spacing: 10) {
                    TitleLabel(text: "Welcome To \n Svadhyay")
                        .padding(.top,50)

                    PNGImageView(imageName: "laptop", width: 150, height: 150)
                    // Login Form
                    VStack(spacing: 10) {
                        CustomTextField(placeholder: "Email", text: $email)
                            .keyboardType(.emailAddress)
                            .onChange(of:email){
                                newValue in isEmailValid = AuthValidation.shared.validateEmail(email: newValue)
                                
                            }
                        HStack{
                            Spacer()
                            if !isEmailValid{
                                Text("Invalid Email address")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.trailing,15)
                            }
                            else{
                                Text("Invalid Email address")
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .padding(.trailing,15)
                                    .opacity(0)
                            }
                        }
                        
                    }
                    
                    CustomSecureField(placeholder: "Password", text: $password)
                    HStack{
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Implement forgot password logic here
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .padding(.trailing ,15)
                    }
                    CustomButton(label: "Login",action: {loginUser()})
                    NavigationLink(destination: ContentView1(), isActive: $login) {
                        EmptyView()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Login Action"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    // Sign Up Option
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 15, weight: .regular, design: .default))
                        NavigationLink(destination: AccountView()) {
                            Text("Sign up")
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#6C5DD4"))
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
                    Spacer()
                    Spacer()
                    
                }.padding(10)
                
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
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
            showAlert = false
            login = true
            print("logged in")
        }
    }
    
    func validateEmail(email: String) -> Bool {
                let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
                return emailPredicate.evaluate(with: email)
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
}




