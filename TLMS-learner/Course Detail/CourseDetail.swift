import SwiftUI

struct CourseDetails: View {
    let course: Course
    @State private var isEnrolled: Bool = false
    @State private var isLiked: Bool = false
    @State private var showFullSubtitle: Bool = false
    @State private var showFullDescription: Bool = false
    @State private var showFullInstructorBio: Bool = false

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
                    .font(.custom("Poppins-Bold", size: 24))
                    .padding(.top)
                    .padding(.horizontal, 20)

                Spacer(minLength: 10)

                // Subtitle and enroll button
                VStack(alignment: .leading, spacing: 10) {
                    Text(course.subtitle)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .lineLimit(showFullSubtitle ? nil : 3)
                        .fixedSize(horizontal: false, vertical: true) // Ensure text wraps correctly

                    if !showFullSubtitle && shouldShowShowMoreButton(text: course.subtitle, maxLines: 3) {
                        Button(action: {
                            showFullSubtitle.toggle()
                        }) {
                            Text("Show more")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color("color 2")) // Use "color 2" here
                        }
                        .padding(.horizontal, 20)
                    }
                }

                Spacer(minLength: 15)

                // Students enrolled
                Text("\(course.studentsEnrolled) students enrolled")
                    .font(.custom("Poppins-Bold", size: 20))
                    .foregroundColor(Color("color 2"))
                    .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Created by
                HStack {
                    Text("Created by ")
                        .font(.custom("Poppins-Medium", size: 12))
                        .foregroundColor(.black)
                    +
                    Text(course.creator)
                        .font(.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color("color 2"))
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 5)

                // Last updated
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                    Text("Last Updated \(course.lastUpdated)")
                        .font(.custom("Poppins-Regular", size: 8))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 5)

                // Language
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                    Text(course.language)
                        .font(.custom("Poppins-Regular", size: 8))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Enroll button
                CustomButton(label: isEnrolled ? "Enrolled" : "Enroll Now") {
                    // Enroll action
                    isEnrolled.toggle()
                    print("Enroll Now button tapped")
                }
                .padding(.horizontal, 20)
                .shadow(color: isEnrolled ? Color.purple.opacity(0.6) : Color.clear, radius: 10, x: 0, y: 10)

                // Add to Likes button
                Button(action: {
                    // Toggle liked state
                    isLiked.toggle()
                    print("Add to Likes button tapped")
                }) {
                    Text(isLiked ? "Liked" : "Add to Likes")
                        .font(.custom("Poppins-SemiBold", size: 17))
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
                
                Spacer(minLength: 15)

                // This course includes section with different icons fetched from course model
                SectionView(title: "This course includes", items: course.courseIncludes, iconNames: course.courseIncludeIcons)
                    .padding(.horizontal, 20)
                
                Spacer(minLength: 15)
                
                // Description section (without icon)
                VStack(alignment: .leading) {
                    SectionView(title: "Description", items: [course.description], iconNames: [nil])
                        .padding(.horizontal, 20)
                        .lineLimit(showFullDescription ? nil : 3)
                    
                    if !showFullDescription && shouldShowShowMoreButton(text: course.description, maxLines: 3) {
                        Button(action: {
                            showFullDescription.toggle()
                        }) {
                            Text("Show more")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color("color 2")) // Use "color 2" here
                        }
                        .padding(.horizontal, 20)
                    }
                }

                Spacer(minLength: 15)

                // Instructor
                Text("Instructor")
                    .font(.custom("Poppins-Bold", size: 20))
                    .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Instructor details
                HStack {
                    Image(course.instructorImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(course.instructorName)
                            .font(.custom("Poppins-Bold", size: 16))
                        Text(course.instructorUniversity)
                            .font(.custom("Poppins-Regular", size: 14))
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
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundColor(.gray)
                                .padding(.leading, 4)
                        }
                    }
                    .padding(.leading)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Instructor bio
                VStack(alignment: .leading) {
                    Text(course.instructorBio)
                        .font(.custom("Poppins-Regular", size: 14))
                        .padding(.horizontal, 20)
                        .lineLimit(showFullInstructorBio ? nil : 3)
                    
                    if !showFullInstructorBio && shouldShowShowMoreButton(text: course.instructorBio, maxLines: 3) {
                        Button(action: {
                            showFullInstructorBio.toggle()
                        }) {
                            Text("Show more")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color("color 2")) // Use "color 2" here
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Course Details", displayMode: .inline)
    }

    // Helper function to determine if "Show more" button should be shown
    private func shouldShowShowMoreButton(text: String, maxLines: Int) -> Bool {
        guard let font = UIFont(name: "Poppins-Regular", size: 16) else {
            return false
        }
        
        let lineHeight = font.lineHeight
        let textHeight = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: font)
        let numberOfLines = Int(textHeight / lineHeight)
        
        return numberOfLines > maxLines
    }
}

// Extension to calculate text height
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

struct CourseDetails_Previews: PreviewProvider {
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
