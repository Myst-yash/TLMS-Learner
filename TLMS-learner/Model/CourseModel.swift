import SwiftUI

struct Course: Identifiable, Decodable {
    var id : String = ""
    var imageName: String = ""
    var title: String = ""
    var studentsEnrolled: Int = 0
    var creator: String = ""
    var whatYoullLearn: [String] = []
    var description: String = ""
    var instructorImageName: String = ""
    var instructorName: String = ""
    var instructorBio: String = ""
    var progress: Double? = nil
    var numberOfModules = 0
}


struct HomeCourse:Identifiable{
    var id :String
    var assignedEducator:String
    var courseName:String
    var courseImage:String
    var releaseData:Date
    var target:String
}

struct Module: Identifiable {
    let id = UUID()
    var title: String
    var notesFileName: String?
    var notesUploadProgress: Double
    var videoFileName: String?
    var videoUploadProgress: Double
}

var popularCourses = [
    Course(imageName: "django", title: "Django Fundamentals", instructorName: "William Shakespeare", progress: 0.3),
    Course(imageName: "nodejs", title: "Node.js Basics", instructorName: "William Shakespeare", progress: 0.4),
    Course(imageName: "nodejs", title: "Node.js Basics", instructorName: "William Shakespeare", progress: 0.4),
    Course(imageName: "nodejs", title: "Node.js Basics", instructorName: "William Shakespeare", progress: 0.4),
    Course(imageName: "nodejs", title: "Node.js Basics", instructorName: "William Shakespeare", progress: 0.4),
    Course(imageName: "nodejs", title: "Node.js Basics", instructorName: "William Shakespeare", progress: 0.4),
    Course(imageName: "nodejs", title: "Node.js Basics", instructorName: "William Shakespeare", progress: 0.4)
]

var recommendedCourses = [
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.6),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7),
    Course(imageName: "django", title: "Django se Panga", instructorName: "Batman", progress: 0.7)
]
