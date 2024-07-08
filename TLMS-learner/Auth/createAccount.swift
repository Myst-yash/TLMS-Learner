//
//  createAccount.swift
//  TLMS-learner
//
//  Created by Abid Ali    on 04/07/24.
//



import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AccountView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                    Image("Waves").resizable().scaledToFit()
                        .position(x: 196 , y: 735)
                
                VStack {
                        TitleLabel(text: "Welcome To \nSvadhyay", fontSize: 40)
                        .lineLimit(0)
                        .truncationMode(.tail)
                        .minimumScaleFactor(0.8)
                        .padding(.leading, 20)
                        
//                        Spacer()
                        
                        PNGImageView(imageName: "laptop", width: 200, height: 200)
                        
                        //                    Text("Create Account")
                        //                        .fontWeight(.semibold)
                        //
                        //                        .padding(.top, 5)
                        
                        VStack(spacing: 15) {
                            CustomTextField(placeholder: "FullName", text: $name)
                            CustomTextField(placeholder: "Email", text: $email)
                            CustomSecureField(placeholder: "Password", text: $password)
                            
                            
                            
                        }
                        .padding(.top, 20)
                        
                        CustomButton(label: "Create Account", action:  {                       
                            Auth.auth().createUser(withEmail: email, password: password) {
                            _, error in if let _ = error {
                                print("error")
                            }
                            else{
                                uploadUserDetails()
                                
                            }
                        }
                        }
                        )
                        NavigationLink(destination: ContentView())
                        {
                            Text("Already have an account?")
                                .navigationBarHidden(true)
                                .foregroundColor(Color(hex: "#007AFF"))
                            
                            
                                .padding(.top, 2)
                        }
                        
                        HStack(spacing: 30) {
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
                            .padding(.bottom, 40)
                        }
                    }
                    .navigationBarHidden(true)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Notification"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                }
            }
        .navigationBarBackButtonHidden()
        }
    
    func uploadUserDetails(){
        let datadic = ["Name":name, "Email": email, "Password": password]
        
        let db = Firestore.firestore()
        _ = db.collection("Learners").addDocument(data: datadic)
        { error in
                if let error = error {
                    alertMessage = "Error: \(error.localizedDescription)"
                } else {
                    alertMessage = "Account Created"
                }
                showAlert = true
            }
    }
}

#Preview {
    AccountView()
}


