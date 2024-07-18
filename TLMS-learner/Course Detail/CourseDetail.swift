import SwiftUI

struct CourseDetails: View {

    let courseId:String

    @State var course: Course = Course(
            id: UUID().uuidString,
            imageName: "nodejsCourse",
            title: "Node Js from Scratch",
            studentsEnrolled: 3027,
            creator: "Vasooli Bhai",
            whatYoullLearn: [
                "Set up a Node.js development environment.",
                "Build and deploy RESTful APIs.",
                "Manage data with databases.",
                "Implement and use Node.js modules."
            ],
            description: "Kickstart your backend development journey with our Node.js from Scratch course. Learn to build and deploy efficient, scalable applications, create RESTful APIs, and manage databases.",
            instructorImageName: "VasooliBhai",
            instructorName: "Vasooli Bhai",
            instructorBio: "Meet Vasooli Bhai, the most charming debt collector in the universe! Known for his unique mix of muscle and mayhem, Vasooli Bhai's life motto is 'Money talks, but my fists do the negotiating.' With his hilarious attempts to get his dues and his over-the-top tough guy persona, he's the lovable goon.",
            progress: nil,
            numberOfModules: 4
        )
    @State private var isEnrolled: Bool = false
    @State private var isLiked: Bool = false
    @State private var showAlert = false
    @State private var navigateToNextView = false
    @State private var showFullSubtitle: Bool = false
    @State private var showFullDescription: Bool = false
    @State private var showFullInstructorBio: Bool = false
//    @State var numOfModules:int
    let courseIncludes = [
            "3.5 total hours on-demand video",
            "Assignments and quizzes",
            "Lifetime access",
            "Certificate of completion"
    ]
    let courseIncludeIcons = [
        "play.rectangle.fill",
        "doc.text.fill",
        "infinity",
        "rosette"
    ]

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
                    Text(course.description)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .lineLimit(showFullSubtitle ? nil : 3)
                        .fixedSize(horizontal: false, vertical: true) // Ensure text wraps correctly

//                    if shouldShowShowMoreButton(text: course.subtitle, maxLines: 3) {
//                        Button(action: {
//                            showFullSubtitle.toggle()
//                        }) {
//                            Text(showFullSubtitle ? "Show less" : "Show more")
//                                .font(.custom("Poppins-Regular", size: 16))
//                                .foregroundColor(Color("color 2")) // Use "color 2" here
//                        }
//                        .padding(.horizontal, 20)
//                    }
                }

                Spacer(minLength: 15)

                // Students enrolled
                Text("\(course.studentsEnrolled) students enrolled").accessibilityElement(children: .ignore).accessibilityLabel("\(course.studentsEnrolled) students have enrolled in this course")
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
                    Text(course.instructorName)
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color("color 2"))
                }.accessibilityElement(children: .ignore).accessibilityLabel("This Course is created by \(course.creator)")
                .padding(.horizontal, 20)

                Spacer(minLength: 5)


                // Language
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                    Text("English")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Enroll button
                CustomButton(label: isEnrolled ? "Go to Course" : "Enroll Now") {
                    // Enroll action
                    
                    print("Enroll Now button tapped")
                    if !isEnrolled {
                        FirebaseServices.shared.enrollStudent(courseId: courseId) { ans in
                            if ans {
                                print("enrolled")
                                isEnrolled = true
                                showAlert = true
                            }
            
                            else{
                                print("not enrolled")
                                isEnrolled = false
                            }
                        }
                    }
                    else{
                        navigateToNextView = true
                    }
                }
                    .accessibilityHint("Click on this button to enroll ")
                .padding(.horizontal, 20)
                
//                .shadow(color: isEnrolled ? Color.gray.opacity(0.6) : Color.clear, radius: 10, x: 0, y: 10)
                .foregroundColor(.white)
//                .disabled(isEnrolled)
                .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Congratulations!"),
                                    message: Text("You have successfully enrolled in this course."),
                                    primaryButton: .default(Text("Start This Course"))
                                         {
                                        navigateToNextView = true
                                        // Action for starting the course
                                        print("Start This Course button tapped")
                                        // Add your navigation or action to start the course here
                                    },
                                    secondaryButton: .cancel()
                                )
                        
                }
                NavigationLink(destination: NodeJsCourseView(courseName: course.title, courseImage: course.imageName,educatorName: course.instructorName), isActive: $navigateToNextView) {
                                    EmptyView()
                                }

                // Add to Likes button
                Button(action: {
                    // Toggle liked state
                    if !isLiked{
                        CentralState.shared.likeCourse(id: courseId)
                        isLiked = true
                    }
                    else{
                        CentralState.shared.unlikeCourse(id: courseId)
                        isLiked = false
                    }
                    FirebaseServices.shared.likeAndUnlikeCourse { status in
                        if status{
                            print("course liked or unliked")
                        }
                        else{
                            print("error while liking the course")
                        }
                    }
                    
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


                // This course includes section with different icons fetched from course model
                SectionView(title: "This course includes", items: courseIncludes, iconNames: courseIncludeIcons)
                    .padding(.horizontal, 20)
                
                Spacer(minLength: 15)
                
                // Description section (without icon)
                
                // Instructor
                Text("Instructor")
                    .font(.custom("Poppins-Bold", size: 20))
                    .padding(.horizontal, 20)

                Spacer(minLength: 15)

                // Instructor details
                HStack {
                    AsyncImage(url: URL(string: course.imageName)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())

                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        @unknown default:
                            EmptyView()
                        }
                    }
                        
                    VStack(alignment: .leading) {
                        Text(course.instructorName)
                            .font(.custom("Poppins-Bold", size: 16))
                    }
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
                self.course = fetchedCourse ?? course
            }
            
            self.isEnrolled = CentralState.shared.checkIfEnrolled(id: courseId)
            self.isLiked = CentralState.shared.checkIfLiked(id: courseId)
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
var course: Course = Course(
        id: UUID().uuidString,
        imageName: "nodejsCourse",
        title: "Node Js from Scratch",
        studentsEnrolled: 3027,
        creator: "Vasooli Bhai",
        whatYoullLearn: [
            "Set up a Node.js development environment.",
            "Build and deploy RESTful APIs.",
            "Manage data with databases.",
            "Implement and use Node.js modules."
        ],
        description: "Kickstart your backend development journey with our Node.js from Scratch course. Learn to build and deploy efficient, scalable applications, create RESTful APIs, and manage databases.",
        instructorImageName: "VasooliBhai",
        instructorName: "Vasooli Bhai",
        instructorBio: "Meet Vasooli Bhai, the most charming debt collector in the universe! Known for his unique mix of muscle and mayhem, Vasooli Bhai's life motto is 'Money talks, but my fists do the negotiating.' With his hilarious attempts to get his dues and his over-the-top tough guy persona, he's the lovable goon.",
        progress: nil,
        numberOfModules: 4
    )
