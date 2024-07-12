import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var imageName: String = ""
    var title: String = ""
    var subtitle: String = ""
    var studentsEnrolled: Int = 0
    var creator: String = ""
    var lastUpdated: String = ""
    var language: String = ""
    var whatYoullLearn: [String] = []
    var courseIncludes: [String] = []
    var courseIncludeIcons: [String] = []
    var description: String = ""
    var instructorImageName: String = ""
    var instructorName: String = ""
    var instructorUniversity: String = ""
    var instructorRating: Int = 0
    var instructorStudents: Int = 0
    var instructorBio: String = ""
    var progress: Double? = nil
}


struct HomeCourse{
    var id :String
    var assignedEducator:String
    var courseName:String
    var courseImage:String
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
