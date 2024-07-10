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
            completion(targetNames)
        }
    }
    
    
    func fetchProfileDetails(completion: @escaping (User?) -> Void){
        
        guard let currentUser = Auth.auth().currentUser else{
            print("email not found")
            return
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("Learners")
        
        ref.whereField("Email", isEqualTo: currentUser.email!).getDocuments { querySnapshot, error in
            if error != nil {
                print("Error fetching learners")
                completion(nil)
                return
            }
            
            guard let documents = querySnapshot?.documents, documents.count == 1 else{
                print("Document with the specified email not found or multiple documents found")
                completion(nil)
                return
            }
            
            let document = documents[0]
            let user = documents.compactMap { document in
                        let data = document.data()
                        let id = document.documentID
                        let email = data["Email"] as? String ?? ""
                        let firstName = data["FirstName"] as? String ?? ""
                        let lastName = data["LastName"] as? String ?? ""
                        let password = data["Password"] as? String ?? ""
                        let completedCourses = data["completedCourses"] as? [String] ?? []
                        let enrolledCourses = data["enrolledCourses"] as? [String] ?? []
                        let goal = data["goal"] as? String ?? ""
                        let joinedDate = data["joinedData"] as? String ?? ""
                        let likedCourses = data["likedCourses"] as? [String] ?? []

                        return User(
                            id: id,
                            email: email,
                            firstName: firstName,
                            lastName: lastName,
                            completedCourses: completedCourses,
                            enrolledCourses: enrolledCourses,
                            goal: goal,
                            joinedDate: joinedDate,
                            likedCourses: likedCourses
                        )
            }.first
            completion(user)
            
        }
        
        
        
        
    }
    
    func addFieldToLearnerDocument(email: String, fieldName: String, newData: Any, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let learnersCollection = db.collection("Learners")
        
        // Query the collection to find the document with the specific email
        learnersCollection.whereField("Email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(false)
                return
            }
            
            guard let documents = querySnapshot?.documents, documents.count == 1 else {
                print("Document with the specified email not found or multiple documents found")
                completion(false)
                return
            }
            
            let document = documents[0]
            let documentID = document.documentID
            
            // Update the document with the new field
            learnersCollection.document(documentID).updateData([fieldName: newData]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                    completion(false)
                } else {
                    print("Document successfully updated")
                    completion(true)
                }
            }
        }
    }
    
    func findSelectedGoal(completion: @escaping (String) -> Void ){
        let db = Firestore.firestore()
        let learnersCollection = db.collection("Learners")
        
        
        guard let currentUser = Auth.auth().currentUser else{
            print("email not found")
            return
        }
        
        learnersCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { querySnapshot, error in
            if error != nil {
                print("Error fetching learners")
                completion("")
                return
            }
            
            guard let documents = querySnapshot?.documents, documents.count == 1 else{
                print("Document with the specified email not found or multiple documents found")
                completion("")
                return
            }
            
            let document = documents[0] 
            completion(document.data()["goal"] as! String)
            
        }
        
    }
    
    func updateSelectedGoasl(newData:String,completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        let learnersCollection = db.collection("Learners")
        
        
        guard let currentUser = Auth.auth().currentUser else{
            print("email not found")
            return
        }
        
        learnersCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { querySnapshot, error in
            if error != nil {
                print("Error fetching learners")
                completion(false)
                return
            }
            
            guard let documents = querySnapshot?.documents, documents.count == 1 else{
                print("Document with the specified email not found or multiple documents found")
                completion(false)
                return
            }
            
            let document = documents[0]
            let documentID = document.documentID
            
            // Update the document with the new field
            learnersCollection.document(documentID).updateData(["goal": newData]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                    completion(false)
                } else {
                    print("Document successfully updated")
                    completion(true)
                }
            }
            
        }
    }
    
    
}
