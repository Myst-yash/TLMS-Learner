import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    let title: String
    let instructor: String
    let imageName: String
    let progress: Double?
}

let popularCourses = [
    Course(title: "Swift Fundamentals", instructor: "William Shakespeare", imageName: "swift", progress: 0.3),
    Course(title: "Node.js Basics", instructor: "William Shakespeare", imageName: "nodejs", progress: 0.4)
]

let recommendedCourses = [
    Course(title: "Django se Panga", instructor: "Batman", imageName: "django", progress: 0.6),
    Course(title: "Django se Panga", instructor: "Batman", imageName: "django", progress: 0.7)
]
