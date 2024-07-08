import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AccountView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var create = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.white.ignoresSafeArea()
                
                PNGImageView(imageName: "Waves", width: 394, height: 194)
                
                VStack(alignment: .center) {
                    Spacer()
                    TitleLabel(text: "Welcome To \nSvadhyay", fontSize: 40)
                        .lineLimit(0)
                        .truncationMode(.tail)
                        .minimumScaleFactor(0.8)
                        .padding(.leading, 20)
                    
                    PNGImageView(imageName: "laptop", width: 150, height: 150)
                    
                    VStack(spacing: 15) {
                        HStack{
                            TextField("First Name", text: $firstname).padding()
                                .background(Color("#FFFFFF")) // Background color
                                .cornerRadius(12) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray, lineWidth: 1) // Border
                                )
                            
                            TextField("Last Name", text: $lastname).padding()
                                .background(Color("#FFFFFF")) // Background color
                                .cornerRadius(12) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray, lineWidth: 1) // Border
                                )
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        
                        CustomTextField(placeholder: "Email", text: $email)
                        CustomSecureField(placeholder: "Password", text: $password)
                    }
                    .padding(.top, 20)
                    
                    CustomButton(label: "Create Account", action: {
                        Auth.auth().createUser(withEmail: email, password: password) { _, error in
                            if let _ = error {
                                print("error")
                            } else {
                                uploadUserDetails()
                            }
                        }
                    })
                    
                    NavigationLink(destination: CourseCategoriesView(), isActive: $create) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Already have an account?")
                            .navigationBarHidden(true)
                            .foregroundColor(Color(hex: "#007AFF"))
                            .padding(.top, 2)
                    }
                    
                    HStack(spacing: 30) {
                        HStack(spacing: 20) {
                            Button(action: {
                                // Perform Google login action
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
                    Spacer()
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
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
    
    func uploadUserDetails() {
        let datadic = ["FirstName": firstname, "LastName": lastname, "Email": email, "Password": password]
        
        let db = Firestore.firestore()
        _ = db.collection("Learners").addDocument(data: datadic) { error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
            } else {
                alertMessage = "Account Created"
            }
            showAlert = false
            create = true
        }
    }
}

#Preview {
    AccountView()
}
