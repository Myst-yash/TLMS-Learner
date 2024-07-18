import SwiftUI
import FirebaseAuth

// Helper function to format date
func formattedDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy" // Customize date format as needed
    return formatter.string(from: date)
}

struct HomeView: View {
    @State private var selectedGoal: String = "GATE"
    @State private var showDropdown: Bool = false
    @State private var isSearchActive = false
    
    @State var goals: [String] = []
    
    @State private var selectedCourse: Int?
    @State var upcomingCourse:[HomeCourse] = []
    @State var forYouCourse:[HomeCourse] = []
    @State var allCourses:[HomeCourse] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(selectedGoal)
                        .font(.headline)
                        .frame(width: 150)
                        .fontWeight(.bold)
                        .accessibilityLabel("Selected Goal")
                        .accessibilityValue(selectedGoal)
                    
                    Button(action: {
                        showDropdown.toggle()
                    }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                            .accessibilityLabel("Show Dropdown")
                            .accessibilityHint("You can click on it to change your field")
                    }
                    Spacer()
                    Button(action: {
                        isSearchActive = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .accessibilityLabel("Search")
                            .accessibilityHint("You can click on it to search courses")
                    }
                    .background(
                        NavigationLink(destination: SearchBar(courses: allCourses), isActive: $isSearchActive) {
                            EmptyView()
                        }
                    )
                    .background(Color.white)
                    .cornerRadius(8)
                    .lineLimit(1)
                    .padding(20)
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Popular Courses")
                                .font(.title2).bold()
                                .accessibilityLabel("Popular Courses")
                            Spacer()
                            Button(action: {
                                // Action for "See All"
                            }) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("See All Popular Courses")
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<5) { index in
                                    Button(action: {
                                        selectedCourse = index
                                        // Add your action here
                                        print("PopularCoursesCard tapped")
                                    }) {
                                        PopularCoursesCard()
                                            
                                            
                                    }.buttonStyle(PlainButtonStyle()).accessibilityLabel("Popular Course \(index + 1)")
                                        .accessibilityHint("You can click on it to enroll in this course")
                                }
                            }
                            .padding(.leading, 20)
                        }
                        NavigationLink(destination: CourseDetails(courseId: "01"), tag: 0, selection: $selectedCourse) {
                            EmptyView()
                        }
                        
                        HStack {
                            Text("For You")
                                .font(.title2).bold()
                                .accessibilityLabel("For You")
                            Spacer()
                            NavigationLink(destination: ForYouCoursesView()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("See All For You Courses")
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(forYouCourse.prefix(5)) { course in
                                    NavigationLink(destination: CourseDetails(courseId: course.id)) {
                                        ContinueWatchingCard(courseName: course.courseName, courseImageURl: course.courseImage, educatorName: course.assignedEducator)
                                            .accessibilityElement(children: /*@START_MENU_TOKEN@*/.ignore/*@END_MENU_TOKEN@*/)
                                            .accessibilityLabel("For you course \(course.courseName) by \(course.assignedEducator)")
                                            .accessibilityHint("You can click on it to enroll in this course")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.leading, 20)
                        }
                        
                        HStack {
                            Text("Upcoming Courses")
                                .font(.title2).bold()
                                .accessibilityLabel("Upcoming Courses")
                            Spacer()
                            NavigationLink(destination: AllUpcomingCoursesView()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .accessibilityLabel("See All Upcoming Courses")
                            
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            VStack(spacing: -10) {
                                ForEach(upcomingCourse, id: \.id) { course in
                                    UpcomingCourseCard(courseName: course.courseName, releaseDate: course.releaseData, courseImageUrl: course.courseImage, educatorName: course.assignedEducator)
                                        .accessibilityElement(children: .ignore)
                                        .accessibilityLabel("Upcoming Course \(course.courseName) by \(course.assignedEducator) releasing on \(formattedDate(date: course.releaseData))")
                                        .accessibilityHint("You can access this course when it is published")
                                }
                            }
                            .padding(.leading, 30)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $showDropdown) {
                VStack {
                    Text("My goals")
                        .font(.headline)
                        .padding()
                        .accessibilityLabel("My goals")
                    
                    Divider()
                    
                    ForEach(goals, id: \.self) { goal in
                        Button(action: {
                            selectedGoal = goal
                            showDropdown = false
                            FirebaseServices.shared.updateSelectedGoasl(newData: goal) { success in
                                if success {
                                    print("Goal updated")
                                } else {
                                    print("There is an issue with it")
                                }
                            }
                        }) {
                            HStack {
                                Text(goal)
                                Spacer()
                                if goal == selectedGoal {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("color 2"))
                                        .accessibilityLabel("Selected")
                                }
                            }
                            .padding()
                        }
                        .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showDropdown = false
                    }) {
                        Text("Close")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("color 2"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .accessibilityLabel("Close")
                    }
                    .padding()
                }
                .background(Color(.systemGray6))
                .onAppear {
                    FirebaseServices.shared.fetchTargets { fetchedTargets in
                        self.goals = fetchedTargets
                        print(fetchedTargets)
                    }
                }
            }
            .onAppear {
                FirebaseServices.shared.findSelectedGoal { userGoal in
                    self.selectedGoal = userGoal
                }
                
                Task {
                    do {
                        let fetchedCourses = try await FirebaseServices.shared.fetchCourses()
                        let now = Date()
                        self.upcomingCourse = fetchedCourses.filter { course in
                            return course.releaseData > now
                        }
                        
                        self.forYouCourse = fetchedCourses.filter { course in
                            return course.target == selectedGoal
                        }
                        if forYouCourse.isEmpty {
                            self.forYouCourse = fetchedCourses
                        }
                        
                        self.allCourses = fetchedCourses
                    } catch {
                        // Handle the error appropriately
                        print("Error fetching courses: \(error)")
                    }
                }
                FirebaseServices.shared.fetchEnrolledCourseIds { arr in
                    CentralState.shared.updateEnrolledCourse(arr: arr)
                }
                
                FirebaseServices.shared.fetchLikedCourseIds { fetchedCourses in
                    CentralState.shared.updateLikedCourse(arr: fetchedCourses)
                }
                print(CentralState.shared.likedCourse)
            }
            .onChange(of: selectedGoal) { newGoal in
                FirebaseServices.shared.findSelectedGoal { userGoal in
                    self.selectedGoal = userGoal
                }
                Task {
                    do {
                        let fetchedCourses = try await FirebaseServices.shared.fetchCourses()
                        let now = Date()
                        self.upcomingCourse = fetchedCourses.filter { course in
                            return course.releaseData > now
                        }
                        
                        self.forYouCourse = fetchedCourses.filter { course in
                            return course.target == selectedGoal
                        }
                        if forYouCourse.isEmpty {
                            self.forYouCourse = fetchedCourses
                        }
                        
                        self.allCourses = fetchedCourses
                    } catch {
                        // Handle the error appropriately
                        print("Error fetching courses: \(error)")
                    }
                }
            }
        }
    }
}

struct ContinueWatchingCard: View {
    var courseName: String
    var courseImageURl: String
    var educatorName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            AsyncImage(url: URL(string: courseImageURl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 300, height: 150)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 140, height: 80)
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
                }
            }
            .accessibilityLabel(courseName)
            .accessibilityHint("Image of the course")
            
            Image("glass")
                .accessibilityHidden(true)
            Image("glassCart").padding(.top, 90)
                .accessibilityHidden(true)
            
            Text(courseName)
                .foregroundStyle(Color.white)
                .fontWeight(.bold)
                .padding()
                .padding(.top, 85)
                .frame(width: 190)
                .padding(.leading, -15)
                .accessibilityLabel("Course Name")
                .accessibilityValue(courseName)
                
            Image("edu").padding(.top, 100).padding(.leading, 210)
                .accessibilityHidden(true)
            Text(educatorName)
                .font(.footnote)
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 100)
                .padding(.leading, 220)
                .accessibilityLabel("Educator Name")
                .accessibilityValue(educatorName)
        }
        .accessibilityElement(children: .combine)
    }
}

struct PopularCoursesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                VStack {
                    Image("swift")
                        .resizable()
                        .frame(width: 356, height: 160)
                        .accessibilityLabel("Swift Course Image")
                    
                    Text("All about Swift")
                        .font(.title3)
                        .bold()
                        .padding(.leading, -155)
                        .padding(.top, 5)
                        .fontWeight(.semibold)
                        .accessibilityLabel("Course Title")
                        .accessibilityValue("All about Swift")
                    
                    Text("by batman")
                        .padding(.leading, -154)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .accessibilityLabel("Instructor Name")
                        .accessibilityValue("Batman")
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
}

struct UpcomingCourseCard: View {
    var courseName: String
    var releaseDate: Date
    var courseImageUrl: String
    var educatorName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: courseImageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 140, height: 80)
                            .cornerRadius(8)
                            .accessibilityLabel("Upcoming Course Image")
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 140, height: 80)
                            .cornerRadius(8)
                            .accessibilityLabel("Image not available")
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(courseName)
                        .font(.headline)
                        .accessibilityLabel("Course Name")
                        .accessibilityValue(courseName)
                    Text(educatorName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel("Educator Name")
                        .accessibilityValue(educatorName)
                    Text("\(formattedDate(date: releaseDate))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel("Release Date")
                        .accessibilityValue("\(formattedDate(date: releaseDate))")
                }
                Spacer()
            }
            .padding(.leading, 10)
            Divider()
        }
        .padding().padding(.leading, -40).padding(.top, -20)
        .accessibilityElement(children: .combine)
    }
    
    // Helper function to format date
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Customize date format as needed
        return formatter.string(from: date)
    }
}

#Preview {
    HomeView()
}
