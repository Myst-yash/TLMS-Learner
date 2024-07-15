import SwiftUI
import FirebaseAuth

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var selectedGoal: String = "GATE"
    @State private var showDropdown: Bool = false
    @State private var isSearchActive = false
    
    @State var goals: [String] = []

    @State private var selectedCourse: Int?
    @State var upcomingCourse:[HomeCourse] = []
    @State var forYouCourse:[HomeCourse] = []
    @State var allCourses:[HomeCourse] = []
//    var course : Course
    var body: some View {
        NavigationStack {
            VStack {
                HStack() {
                    Text(selectedGoal)
                        .font(.headline)
                        .frame(width: 150)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        showDropdown.toggle()
                    }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                            isSearchActive = true}) {
                                                         
                            Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)}
                            .background(
                            NavigationLink(destination: SearchBar(), isActive: $isSearchActive) {
                              
                            })}
                            .background(Color.white)
                            .cornerRadius(8)
                            .lineLimit(1)
                            .padding(20)

                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Popular Courses")
                                .font(.title2).bold()
                            Spacer()
                            Button(action: {
                                // Action for "See All"
                            }) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
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
                                    }.buttonStyle(PlainButtonStyle())
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
                            Spacer()
                            NavigationLink(destination: MyCourses()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(forYouCourse.prefix(5)) { course in
                                    NavigationLink(destination: CourseDetails(courseId: "01")) { // Replace 'NextView' with your destination view
                                        ContinueWatchingCard(courseName: course.courseName, courseImageURl: course.courseImage)
                                    }
                                    .buttonStyle(PlainButtonStyle()) // Ensures no default button styling is applied
                                    
                                }
                                
                            }
                            .padding(.leading, 20)
                        
                        }
//                        NavigationLink(destination: CourseDetails(courseId: "01"), tag: 0, selection: $selectedCourse) {
//                                            EmptyView()
//                                        }

                        HStack {
                            Text("Upcoming Courses")
                                .font(.title2).bold()
                            Spacer()
                            Button(action: {
                                // Action for "See All"
                            }) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            VStack(spacing: -10) {
                                
                                ForEach(upcomingCourse, id: \.id) { course in
                                    UpcomingCourseCard(courseName: course.courseName, releaseDate: course.releaseData,courseImageUrl:course.courseImage)
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
                    
                    Divider()
                    
                    ForEach(goals, id: \.self) { goal in
                        Button(action: {
                            selectedGoal = goal
                            showDropdown = false
                            updateGoal(newData: goal)
                            
                        }) {
                            HStack {
                                Text(goal)
                                Spacer()
                                if goal == selectedGoal {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("color 2"))
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
                
                FirebaseServices.shared.fetchCourses { fetchedCourses in
                    let now = Date()
                    self.upcomingCourse = fetchedCourses.filter { course in
                        return course.releaseData > now
                    }
                    
                    self.forYouCourse = fetchedCourses.filter({ course in
                        return course.target == selectedGoal
                    })
                    if forYouCourse.isEmpty{
                        self.forYouCourse = fetchedCourses
                    }
                    
                    self.allCourses = fetchedCourses
                }
            }
        }
    }
    
    func updateGoal(newData:String){
        FirebaseServices.shared.updateSelectedGoasl(newData: newData) { success in
            if success {
                print("Goal updated")
            }
            else{
                print("there is an issue with it")
            }
        }
    }
}


struct ContinueWatchingCard: View {
    var courseName:String
    var courseImageURl:String
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
            Image("glass")
            Image("glassCart").padding(.top, 90)
            
                Text(courseName).foregroundStyle(Color.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding().padding(.top, 85)
                
            Image("edu").padding(.top, 100).padding(.leading, 210)
            Text("Batman").font(.footnote).bold().foregroundStyle(.white).padding(.top, 100).padding(.leading, 225)
            Image("heart").padding(.bottom, 100).padding(.leading, 260)
                
            
            
            
            
            
        }
    }
}

struct PopularCoursesCard: View {
//    var course : Course
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                VStack{
                    Image("swift").resizable().frame(width: 356,height: 160)
                    Text("All about Swift").font(.title3).bold().padding(.leading, -155).padding(.top, 5).fontWeight(.semibold)
                    Text("by batman").padding(.leading, -154).font(.subheadline).foregroundColor(.gray)
                    
                }
                
            }
        }
    }
}
struct UpcomingCourseCard: View {
    
    var courseName: String
    var releaseDate: Date
    var courseImageUrl: String // URL for the course image
    
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
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 140, height: 80)
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(courseName)
                        .font(.headline)
                    Text("by Batman") // Assuming static text for now
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(formattedDate(date: releaseDate))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.leading, 10)
            Divider()
        }
        .padding().padding(.leading, -40).padding(.top, -20)
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
