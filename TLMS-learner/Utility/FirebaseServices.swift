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
            
            _ = documents[0]
            let user = documents.compactMap { document in
                        let data = document.data()
                        let id = document.documentID
                        let email = data["Email"] as? String ?? ""
                        let firstName = data["FirstName"] as? String ?? ""
                        let lastName = data["LastName"] as? String ?? ""
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
    
    func fetchEducators(completion: @escaping ([Educators]) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Educators")
        
        ref.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error while fetching Educators: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                completion([])
                return
            }
            
            let educators = documents.compactMap { document -> Educators? in
                let data = document.data()
                let id = document.documentID
                let email = data["email"] as? String ?? ""
                let firstName = data["FirstName"] as? String ?? ""
                let lastName = data["LastName"] as? String ?? ""
                let phonenumber = data["phoneNumber"] as? String ?? ""
                let imageUrl = data["profileImageURL"] as? String ?? ""
                let about = data["about"] as? String ?? ""
                _ = data["assignedCourses"]
                
                return Educators(
                    id: id,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    phonenumber: phonenumber,
                    imageUrl: imageUrl,
                    about: about
                )
            }
            
            completion(educators)
        }
    }
    
    func fetchCourses(completion: @escaping ([HomeCourse]) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Courses")
        
        ref.getDocuments { querySnapshot, err in
            if let err = err {
                print("Error while fetching upcoming Course: \(err)")
                completion([])
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                completion([])
                return
            }
            let courses = documents.compactMap { document -> HomeCourse? in
                let data = document.data()
                let id = data["courseID"] as? String ?? ""
                let assignedEducator = data["EducatorName"] as? String ?? ""
                let courseName = data["courseName"] as? String ?? ""
                let courseImg = data["courseImageURL"] as? String ?? ""
                guard let releaseData = data["releaseDate"] as? Timestamp else { return nil }
                let releaseDate = releaseData.dateValue()
                
                let yourGoal = data["target"] as? String ?? ""
                
                return HomeCourse(id: id, assignedEducator: assignedEducator, courseName: courseName, courseImage: courseImg, releaseData: releaseDate, target: yourGoal)
            }
            completion(courses)
        }
    }

    func fetchLikedCourses(completion: @escaping ([Course]) -> Void) {
        
        guard let currentUser = Auth.auth().currentUser else{
            print("email not found")
            return
        }
        let db = Firestore.firestore()
        
        let learnersCollection = db.collection("Learners")
        let coursesCollection = db.collection("Courses")
        
        learnersCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { (querySnapshot, error) in
            if error != nil {
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("no learner found with this email")
                completion([]) // No learner found with the given email
                return
            }
            
            let learner = documents.compactMap { document -> User? in
                let data = document.data()
                let likedCourseIDs = data["likedCourses"] as? [String] ?? []
                let enrolledCourseIds = data["enrolledCourses"] as? [String] ?? []
                
                return User(id: "", email: "", firstName: "", lastName: "", completedCourses: [], enrolledCourses: enrolledCourseIds, goal: "", joinedDate: "", likedCourses: likedCourseIDs)
            }.first
            
            
            guard let likedCourseIDs = learner?.likedCourses, !likedCourseIDs.isEmpty else {
                print("no liked courses")
                completion([]) // No liked courses
                return
            }
            guard let enrolledCourses = learner?.enrolledCourses, !enrolledCourses.isEmpty else{
                print("no enrolled Courses")
                completion([])
                return
            }
            print(likedCourseIDs)
            var likedCourses: [Course] = []
            let group = DispatchGroup()

            for courseID in likedCourseIDs {
                group.enter()
                coursesCollection.document(courseID).getDocument { (documentSnapshot, error) in
                    defer { group.leave() }

                    if error != nil {
                        completion([])
                        return
                    }

                    if let course = try? documentSnapshot?.data(as: Course.self) {
                        likedCourses.append(course)
                    }

                }
            }

            group.notify(queue: .main) {
                completion(likedCourses)
            }
        }
    }
    
    func fetchCourseDetailsWithId(courseID: String, completion: @escaping (Course?) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Courses")
        
        ref.whereField("courseID", isEqualTo: courseID).getDocuments { snapshot, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                completion(nil) // No course found with the given ID
                return
            }
            
            let document = documents.first!
            let data = document.data()
            
            let course = Course(
                id: UUID(uuidString: data["courseID"] as? String ?? "") ?? UUID(),
                imageName: data["courseImageURL"] as? String ?? "",
                title: data["courseName"] as? String ?? "",
                subtitle: "",
                studentsEnrolled: 0, // Not present in your data
                creator: data["assignedEducator"] as? String ?? "",
                lastUpdated: "",
                language: "",
                whatYoullLearn: [], // Not present in your data
                courseIncludes: [], // Not present in your data
                courseIncludeIcons: [], // Not present in your data
                description: data["courseDescription"] as? String ?? "",
                instructorImageName: "",
                instructorName: "",
                instructorUniversity: "",
                instructorRating: 0,
                instructorStudents: 0,
                instructorBio: "",
                progress: nil
            )
            
            completion(course)
        }
    }
    
    func enrollStudent(courseId:String, completion: @escaping(Bool) -> Void){
        let db = Firestore.firestore()
        let learnerCollection = db.collection("Learners")
        guard let currentUser = Auth.auth().currentUser else{
            print("email not found")
            return
        }
        
        learnerCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { querySnapshot, error in
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
            
            let data = document.data()
            var enrolledCourse = data["enrolledCourses"] as? [String]
            enrolledCourse?.append(courseId)
            
            // Update the document with the new field
            learnerCollection.document(documentID).updateData(["enrolledCourses":enrolledCourse!]) { error in
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
    
    func likeAndUnlikeCourse(completion: @escaping(Bool) -> Void){
        let db = Firestore.firestore()
        let learnerCollection = db.collection("Learners")
        guard let currentUser = Auth.auth().currentUser else{
            print("email not found")
            return
        }
        
        learnerCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { querySnapshot, error in
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
            
//            let data = document.data()
//            var likedCourse = data["likedCourses"] as? [String]
//            likedCourse?.append(courseId)
            
            // Update the document with the new field
            learnerCollection.document(documentID).updateData(["likedCourses":CentralState.shared.likedCourse]) { error in
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
    
    
    func fetchEnrolledCourses(completion: @escaping ([Course]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            print("Email not found")
            return
        }
        let db = Firestore.firestore()

        let learnersCollection = db.collection("Learners")
        let coursesCollection = db.collection("Courses")

        learnersCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching learner: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No learner found with this email")
                completion([]) // No learner found with the given email
                return
            }

            let learner = documents.compactMap { document -> User? in
                let data = document.data()
                let enrolledCourseIds = data["enrolledCourses"] as? [String] ?? []

                return User(
                    id: data["id"] as? String ?? "",
                    email: data["Email"] as? String ?? "",
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    completedCourses: data["completedCourses"] as? [String] ?? [],
                    enrolledCourses: enrolledCourseIds,
                    goal: data["goal"] as? String ?? "",
                    joinedDate: data["joinedDate"] as? String ?? "",
                    likedCourses: data["likedCourses"] as? [String] ?? []
                )
            }.first

            guard let enrolledCourseIDs = learner?.enrolledCourses, !enrolledCourseIDs.isEmpty else {
                print("No enrolled courses")
                completion([]) // No enrolled courses
                return
            }

//            print("Enrolled Courses IDs: \(enrolledCourseIDs)")

            var enrolledCourses: [Course] = []

            let group = DispatchGroup()

            for courseID in enrolledCourseIDs {
                group.enter()
                coursesCollection.whereField("courseID", isEqualTo: courseID).getDocuments { (querySnapshot, error) in
                    defer { group.leave() }

                    if let error = error {
                        print("Error fetching enrolled course: \(error.localizedDescription)")
                        return
                    }

                    guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                        print("No data for course ID: \(courseID)") // Debug print
                        return
                    }

                    for document in documents {
                        let data = document.data()
                        let course = Course(
                            id: UUID(uuidString: data["courseID"] as? String ?? "") ?? UUID(),
                            imageName: data["courseImageURL"] as? String ?? "",
                            title: data["courseName"] as? String ?? "",
                            subtitle: "",
                            studentsEnrolled: 0, // Not present in your data
                            creator: data["assignedEducator"] as? String ?? "",
                            lastUpdated: "",
                            language: "",
                            whatYoullLearn: [], // Not present in your data
                            courseIncludes: [], // Not present in your data
                            courseIncludeIcons: [], // Not present in your data
                            description: data["courseDescription"] as? String ?? "",
                            instructorImageName: "",
                            instructorName: "",
                            instructorUniversity: "",
                            instructorRating: 0,
                            instructorStudents: 0,
                            instructorBio: "",
                            progress: nil
                        )
                        enrolledCourses.append(course)
//                        print("Course appended: \(course.title)") // Debug print
                    }
                }
            }

            group.notify(queue: .main) {
//                print("All courses fetched, total: \(enrolledCourses.count)") // Debug print
                completion(enrolledCourses)
            }
        }
    }
    
    func fetchEnrolledCourseIds(completion: @escaping ([String]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            print("Email not found")
            return
        }
        let db = Firestore.firestore()

        let learnersCollection = db.collection("Learners")
        _ = db.collection("Courses")

        learnersCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching learner: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No learner found with this email")
                completion([]) // No learner found with the given email
                return
            }

            let learner = documents.compactMap { document -> User? in
                let data = document.data()
                let enrolledCourseIds = data["enrolledCourses"] as? [String] ?? []

                return User(
                    id: data["id"] as? String ?? "",
                    email: data["Email"] as? String ?? "",
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    completedCourses: data["completedCourses"] as? [String] ?? [],
                    enrolledCourses: enrolledCourseIds,
                    goal: data["goal"] as? String ?? "",
                    joinedDate: data["joinedDate"] as? String ?? "",
                    likedCourses: data["likedCourses"] as? [String] ?? []
                )
            }.first

            guard let enrolledCourseIDs = learner?.enrolledCourses, !enrolledCourseIDs.isEmpty else {
                print("No enrolled courses")
                completion([]) // No enrolled courses
                return
            }

//            print("Enrolled Courses IDs: \(enrolledCourseIDs)")
            completion(enrolledCourseIDs)
        }
    }
    
    func fetchLikedCourseIds(completion: @escaping ([String]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            print("Email not found")
            return
        }
        let db = Firestore.firestore()

        let learnersCollection = db.collection("Learners")
        _ = db.collection("Courses")

        learnersCollection.whereField("Email", isEqualTo: currentUser.email!).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching learner: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No learner found with this email")
                completion([]) // No learner found with the given email
                return
            }

            let learner = documents.compactMap { document -> User? in
                let data = document.data()
                let enrolledCourseIds = data["likedCourses"] as? [String] ?? []

                return User(
                    id: data["id"] as? String ?? "",
                    email: data["Email"] as? String ?? "",
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    completedCourses: data["completedCourses"] as? [String] ?? [],
                    enrolledCourses: enrolledCourseIds,
                    goal: data["goal"] as? String ?? "",
                    joinedDate: data["joinedDate"] as? String ?? "",
                    likedCourses: data["likedCourses"] as? [String] ?? []
                )
            }.first

            guard let likedCourseIDs = learner?.likedCourses, !likedCourseIDs.isEmpty else {
                print("No liked courses")
                completion([]) // No enrolled courses
                return
            }

//            print("liked Courses IDs: \(likedCourseIDs)")
            completion(likedCourseIDs)
        }
    }


    

}
    
    

