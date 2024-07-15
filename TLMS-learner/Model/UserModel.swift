import Foundation

struct User: Decodable {
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    var completedCourses: [String]
    var enrolledCourses: [String]
    var goal: String
    var joinedDate: String
    var likedCourses: [String]
}
