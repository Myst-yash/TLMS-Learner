//
//  Chat Model.swift
//  TLMS-learner
//
//  Created by Mac on 17/07/24.
//

import Foundation
import SwiftUI

struct Message: Decodable, Identifiable,Equatable,Hashable{
    let id : UUID
    let useruid:String
    let text : String
    let photoURL: String?
    let createdAt: Date
    
    func isFromCurrentUser()->Bool {
        guard let currUser = AuthManager.shared.getCurrentUser() else {
            return false
        }
        if currUser.uid == useruid {
            return true
        }else {
            return false
        }
    }
    func fetchPhotoURL()-> URL? {
        guard let photoURLString = photoURL,let url = URL(string: photoURLString) else {
            return nil
        }
        return url
    }
}
