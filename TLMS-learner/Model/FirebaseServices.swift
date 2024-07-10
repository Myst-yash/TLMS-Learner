//
//  FirebaseServices.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 10/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class FirebaseServices{
    static let shared = FirebaseServices()
    func fetchTargets(completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Targets")
        
        ref.getDocuments { (querySnapshot, error) in
            if let _ = error {
                print("Error fetching the target names.")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Documents couldn't be fetched.")
                completion([])
                return
            }
            
            let targetNames = documents.map {$0.documentID}
//            print(targetNames)
            completion(targetNames)
            
        }
    }
}
