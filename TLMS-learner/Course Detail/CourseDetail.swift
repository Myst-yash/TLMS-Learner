import SwiftUI

struct CourseDetails: View {

    let courseId:String

    @State var course: Course =  Course(
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
    @State private var isEnrolled: Bool = false
    @State private var isLiked: Bool = false
    @State private var showAlert = false
    @State private var navigateToNextView = false
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
                        AsyncImage(url: URL(string: course.imageName)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 355, height: 206)
                                    .clipped()
                            case .failure:
                                ProgressView()
                            @unknown default:
                                EmptyView()
                            }
                        }
//                        Image(course.imageName)
                            
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

                    if shouldShowShowMoreButton(text: course.subtitle, maxLines: 3) {
                        Button(action: {
                            showFullSubtitle.toggle()
                        }) {
                            Text(showFullSubtitle ? "Show less" : "Show more")
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
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(.black)
                    +
                    Text(course.creator)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color("color 2"))
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 5)

                // Last updated
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.gray)
                    Text("Last Updated \(course.lastUpdated)")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 5)

                // Language
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                    Text(course.language)
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Enroll button
                CustomButton(label: isEnrolled ? "Go to Course" : "Enroll Now") {
                    // Enroll action
                    isEnrolled.toggle()
                    print("Enroll Now button tapped")
                    if isEnrolled {
                        FirebaseServices.shared.enrollStudent(courseId: courseId) { ans in
                            if ans {
                                print("enrolled")
                                showAlert = true
                            }
                            else{
                                print("not enrolled")
                                isEnrolled = false
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
//                .shadow(color: isEnrolled ? Color.gray.opacity(0.6) : Color.clear, radius: 10, x: 0, y: 10)
                .foregroundColor(.white)
//                .disabled(isEnrolled)
                .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Congratulations!"),
                                    message: Text("You have successfully enrolled in this course."),
                                    primaryButton: .default(Text("Start This Course")) {
                                        navigateToNextView = true
                                        // Action for starting the course
                                        print("Start This Course button tapped")
                                        // Add your navigation or action to start the course here
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                NavigationLink(destination: NodeJsCourseView(), isActive: $navigateToNextView) {
                                    EmptyView()
                                }

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
                .padding(.horizontal, 20).padding(.top , 10)

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
                    
                    if shouldShowShowMoreButton(text: course.description, maxLines: 3) {
                        Button(action: {
                            showFullDescription.toggle()
                        }) {
                            Text(showFullDescription ? "Show less" : "Show more")
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
                                        .foregroundColor(Color("color 2"))
                                }
                                ForEach(course.instructorRating..<5, id: \.self) { _ in
                                    Image(systemName: "star")
                                        .foregroundColor(Color("color 2"))
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
                    
                    if shouldShowShowMoreButton(text: course.instructorBio, maxLines: 3) {
                        Button(action: {
                            showFullInstructorBio.toggle()
                        }) {
                            Text(showFullInstructorBio ? "Show less" : "Show more")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color("color 2")) // Use "color 2" here
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationTitle("course")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .navigationBarTitle("Course Details", displayMode: .inline)
        .onAppear(perform: {
            FirebaseServices.shared.fetchCourseDetailsWithId(courseID: courseId) { fetchedCourse in
                self.course.imageName = fetchedCourse?.imageName ?? course.imageName
                self.course.title = fetchedCourse?.title ?? course.title
                self.course.description = fetchedCourse?.description ?? course.description
            }
        })
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
        CourseDetails(courseId: "F1AAA783-67A4-4554-A15C-D6B4A78729BE"
)
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
