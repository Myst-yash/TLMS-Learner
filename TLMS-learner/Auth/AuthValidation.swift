//
//  RegexFields.swift
//  TLMS-learner
//
//  Created by Abcom on 08/07/24.
//

import Foundation
import FirebaseAuth
class AuthValidation{
    static var shared = AuthValidation()
     func validateName(name: String) -> Bool {
            let nameRegex = "^[a-zA-Z]( ?[a-zA-Z]){1,19}$"
            let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            return namePredicate.evaluate(with: name)
        }

    func validateEmail(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func validatePassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func checkFullName(fName:String,lName:String)->Bool{
        return fName != lName
    }
}
struct ChatRoomUser {
    let uid: String
    let name: String
    let email: String?
    let photoUrl: String?
}

final class AuthManager {
    static let shared = AuthManager()
    let auth = Auth.auth()
    
    func getCurrentUser() -> ChatRoomUser? {
        guard let user = auth.currentUser else {
            return nil
        }
        return ChatRoomUser(uid: user.uid, name: user.displayName ?? "Unknown", email: user.email, photoUrl: user.photoURL?.absoluteString)
    }
}
