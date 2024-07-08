//
//  TLMS_learnerApp.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 03/07/24.
//

import SwiftUI
import Firebase

class AppDelegate:NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TLMS_learnerApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
