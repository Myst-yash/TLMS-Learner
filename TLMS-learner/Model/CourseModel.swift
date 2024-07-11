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
