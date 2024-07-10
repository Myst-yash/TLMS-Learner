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
    @State private var isFirstNameValid: Bool = true
    @State private var isLastNameValid: Bool = true
    @State private var isEmailValid: Bool = true
    @State private var isPasswordValid: Bool = true
    @State private var checkFullName = true
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
//                Color.white.ignoresSafeArea()
                
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
                                .background(Color.white) // Background color
                                .cornerRadius(12) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray, lineWidth: 1) // Border
                                )
                                .onChange(of: firstname) { newValue in
                                    isFirstNameValid = AuthValidation.shared.validateName(name: newValue)
                                }
                            
                            
                            
                            TextField("Last Name", text: $lastname).padding()
                                .background(Color.white) // Background color
                                .cornerRadius(12) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray, lineWidth: 1) // Border
                                )
                                .onChange(of: lastname) { newValue in
                                    isLastNameValid = AuthValidation.shared.validateName(name: newValue)
                                    checkFullName = AuthValidation.shared.checkFullName(fName: firstname, lName: lastname)
                                }
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        
                            if !isFirstNameValid {
                                Text("First name should be 2-20 alphabetic characters.")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.trailing,15)
                            }
                            
                        if !isLastNameValid {
                            Text("Last name should be 2-20 alphabetic characters.")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.trailing,15)
                        }
                        
                        if !checkFullName{
                            Text("first name and last name should not be same")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.trailing,15)
                        }
                        CustomTextField(placeholder: "Email", text: $email)
                            .keyboardType(.emailAddress)
                            .onChange(of:email){
                                newValue in isEmailValid = AuthValidation.shared.validateEmail(email: newValue)
                            }
                        
                            if !isEmailValid {
                                Text("invalid email")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.trailing,15)
                            }
                           
                        
                        CustomSecureField(placeholder: "Password", text: $password)
                            .onChange(of:password){
                                newValue in isPasswordValid = AuthValidation.shared.validatePassword(password: password)
                            }
                        
                            if !isPasswordValid{
                                Text("Enter a Strong password")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.trailing,15)
                            }
                            
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
                            .foregroundColor(Color("color 1"))
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
        let joinedDate = currentDateFormatted()
        let datadic = [
            "FirstName": firstname,
            "LastName": lastname,
            "Email": email.lowercased(),
            "Password": password,
            "joinedData": joinedDate,
            "enrolledCourses": [String](),
            "completedCourses":[String](),
            "likedCourses":[String]()
        ] as [String : Any]

        
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
    
    func currentDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: Date())
    }
    
}

#Preview {
    AccountView()
}
