import SwiftUI

struct CourseDetails: View {
    let course: Course
    @State private var isEnrolled: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Image
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 355, height: 206)
                    .background(
                        Image(course.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 355, height: 206)
                            .clipped()
                        )
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 1, y: 2)
                        .padding(.horizontal, 20)
                // Title
                Text(course.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .padding(.horizontal, 20)

                Spacer(minLength: 10)

                // Subtitle and enroll button
                Text(course.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)

                Spacer(minLength: 15)

                Text("\(course.studentsEnrolled) students enrolled")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding(.horizontal, 20)

                Spacer(minLength: 15)

                HStack {
                    Text("Created by ")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    +
                    Text(course.creator)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.purple)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 5)

                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                    Text("Last Updated \(course.lastUpdated)")
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 5)

                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                    Text(course.language)
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 15)

                Button(action: {
                    // Enroll action
                    isEnrolled.toggle()
                }) {
                    Text(isEnrolled ? "Enrolled" : "Enroll Now")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isEnrolled ? Color.purple.opacity(0.8) : Color.purple)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)

                Button(action: {
                    // Add to Likes action
                }) {
                    Text("Add to Likes")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 20)

                // What you'll learn section with checkmark icon
                SectionView(title: "What you'll learn", items: course.whatYoullLearn, iconNames: Array(repeating: "checkmark", count: course.whatYoullLearn.count))
                    .padding(.horizontal, 20)

                // This course includes section with different icons fetched from course model
                SectionView(title: "This course includes", items: course.courseIncludes, iconNames: course.courseIncludeIcons)
                    .padding(.horizontal, 20)

                // Description section (without icon)
                SectionView(title: "Description", items: [course.description], iconNames: [nil])
                    .padding(.horizontal, 20)

                // Instructor
                Text("Instructor")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)

                Spacer(minLength: 15)

                HStack {
                    Image(course.instructorImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(course.instructorName)
                            .font(.headline)
                        Text(course.instructorUniversity)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        HStack {
                            HStack(spacing: 2) {
                                ForEach(0..<course.instructorRating, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.purple)
                                }
                                ForEach(course.instructorRating..<5, id: \.self) { _ in
                                    Image(systemName: "star")
                                        .foregroundColor(.purple)
                                }
                            }
                            Text("\(course.instructorStudents) students")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.leading, 4)
                        }
                    }
                    .padding(.leading)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 15)

                Text(course.instructorBio)
                    .padding(.bottom)
                    .padding(.horizontal, 20)
            }
            .padding()
        }
        .padding(.vertical, 15)
        .navigationBarTitle("Course Details", displayMode: .inline)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetails(course: sampleCourse)
    }
}

// Sample Course Data
let sampleCourse = Course(
    imageName: "nodejsCourse",
    title: "Node Js from Scratch",
    subtitle: "Master Node.js basics, build APIs, work with databases, and deploy apps. Ideal for beginners in backend development.",
    studentsEnrolled: 3027,
    creator: "Vasooli Bhai",
    lastUpdated: "24/06/2024",
    language: "English",
    whatYoullLearn: [
        "Set up a Node.js development environment.",
        "Build and deploy RESTful APIs.",
        "Manage data with databases.",
        "Implement and use Node.js modules."
    ],
    courseIncludes: [
        "3.5 total hours on-demand video",
        "Assignments and quizzes",
        "Lifetime access",
        "Certificate of completion"
    ],
    courseIncludeIcons: [
        "play.rectangle.fill",
        "doc.text.fill",
        "infinity",
        "rosette"
    ],
    description: "Kickstart your backend development journey with our Node.js from Scratch course. Learn to build and deploy efficient, scalable applications, create RESTful APIs, and manage databases.",
    instructorImageName: "VasooliBhai",
    instructorName: "Vasooli Bhai",
    instructorUniversity: "University of Golmaal",
    instructorRating: 4,
    instructorStudents: 1823,
    instructorBio: "Meet Vasooli Bhai, the most charming debt collector in the universe! Known for his unique mix of muscle and mayhem, Vasooli Bhai's life motto is 'Money talks, but my fists do the negotiating.' With his hilarious attempts to get his dues and his over-the-top tough guy persona, he's the lovable goon."
)
