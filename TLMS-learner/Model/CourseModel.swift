import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    let title: String
    let instructor: String
    let imageName: String
}

let popularCourses = [
    Course(title: "Swift Fundamentals", instructor: "William Shakespeare", imageName: "swift"),
    Course(title: "Node.js Basics", instructor: "William Shakespeare", imageName: "nodejs")
]

let recommendedCourses = [
    Course(title: "Django se Panga", instructor: "Batman", imageName: "django"),
    Course(title: "Django se Panga", instructor: "Batman", imageName: "django")
]
