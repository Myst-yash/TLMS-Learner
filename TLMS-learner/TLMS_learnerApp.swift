//
//  TLMS_learnerApp.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 03/07/24.
//

import SwiftUI
import Firebase

@main
struct TLMS_learnerApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AccountView()
        }
    }
}
