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
    @State private var login = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                        
                        PNGImageView(imageName: "Waves", width: 395.0, height: 195.0)

                        VStack(alignment : .center ,spacing: 30){
                            
                                TitleLabel(text: "Welcome To Swadhyay")
                                .padding(.top ,80)
                                PNGImageView(imageName: "laptop", width: 139, height: 107)

                                VStack(spacing: 20) {
                                    HeadingLabel(text: "Sign to your Admin Account")
                                    CustomTextField(placeholder: "Email", text: $email)
                                    CustomSecureField(placeholder: "Enter password", text: $password, placeholderOpacity: 0.3)
                                }

                            CustomButton(label: "Login" , action: {loginUser()})
                            NavigationLink(destination: CourseCategoriesView(), isActive: $login) {
                                EmptyView()
                            
                            }
                                
                               Spacer()
                        }.padding(20)
                        
                           
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
                        
                    }
                    .ignoresSafeArea()
        }
    }
    
    func loginUser(){
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, err in
            if let err = err{
                alertMessage = err.localizedDescription
                showAlert = true
//                login = true
                print("not logged in")
                return
            }
//            alertMessage = "you've logged in"
//            showAlert = false
            login = true
            print("logged in")
//
        }
    }
    
    struct SignupView: View {
        var body: some View {
            Text("Signup View")
                .navigationBarHidden(true)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
#Preview {
    ContentView()
}


/*
 
 NavigationView {
     ZStack(alignment:.bottom) {
//                Color("#FFFFFF")
//                    .edgesIgnoringSafeArea(.all)
         
         PNGImageView(imageName: "Waves", width: 394, height: 194)
             // Extend to ignore safe area insets
         
         
         VStack(spacing: 20) {
             
             
             TitleLabel(text: "Welcome To Svadhyay")
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
                 
                 VStack{
                     CustomButton(label: "Login",action: {loginUser()})
                                                 NavigationLink(destination: CourseCategoriesView(), isActive: $login) {
                                                     EmptyView()
                                                 }
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
 .navigationBarBackButtonHidden()
 */
