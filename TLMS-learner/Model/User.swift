import Foundation

struct User {
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    var completedCourses: [String]
    var enrolledCourses: [String]
    var goal: String
    var joinedDate: String
    var likedCourses: [String]

    init(id: String, email: String, firstName: String, lastName: String, completedCourses: [String], enrolledCourses: [String], goal: String, joinedDate: String, likedCourses: [String]) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.completedCourses = completedCourses
        self.enrolledCourses = enrolledCourses
        self.goal = goal
        self.joinedDate = joinedDate
        self.likedCourses = likedCourses
    }
}
