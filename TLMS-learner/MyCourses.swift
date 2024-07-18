import SwiftUI

struct MyCourses: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSegment = 0
    let segments = ["Ongoing", "Completed"]
    @State var ongoingCourse = [Course]()
    @State var completedCourse = [Course]()
    
    init() {
        //      Sets the background color of the Picker
        UISegmentedControl.appearance().backgroundColor = UIColor(named: "#FAFAFA")
        //      Disappears the divider
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        //      Changes the color for the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "color 2")
        //      Changes the text color for the selected item
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        //      Customize the navigation bar appearance
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                segmentControl
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                
                ScrollView {
                    VStack {
                        ForEach(selectedSegment == 0 ? ongoingCourse : completedCourse) { course in
                            ForYouCourseCard(course: course)
                                
                        }
                        if selectedSegment == 0 && ongoingCourse.isEmpty{
                            Text("No Ongoing Courses")
                                .padding(.top, 250).accessibilityLabel("There are no ongoing courses at this moment.")
                                
                            
                        }
                        
                        else if selectedSegment != 0 && completedCourse.isEmpty{
                            Text("No Completed Course")
                                .padding(.top, 250).accessibilityLabel("You have not completed any courses yet.")
                        }
                    }
                    .padding(.top, 20)
                }
            }.padding(20)
            
            .navigationTitle("My Courses")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task{
                    do{
                        let courses = try await FirebaseServices.shared.fetchAllEnrolledCourse()
                        self.ongoingCourse = courses
                        print(self.ongoingCourse)
                    }
                    catch{
                        print("Error fetching enrolled courses: \(error)")
                    }
                }
            }
        }
    }
    
    var segmentControl: some View {
        Picker("Segments", selection: $selectedSegment) {
            ForEach(0..<segments.count, id: \.self) { index in
                Text(segments[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct ForYouCourseCard: View {
    var course: Course
    
    var body: some View {
        Button(action: {}) {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1)) // Placeholder background
                        .frame(width: 100, height: 60)
                        .cornerRadius(10)
                    
                    AsyncImage(url: URL(string: course.imageName)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 60) // Ensure ProgressView takes the same space
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 149, height: 86)
                                .cornerRadius(8)
                                .padding(.leading, 6)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                    .frame(width: 149, height: 86)
                                    .cornerRadius(8)
                                    .padding(.leading, 6)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(course.title)
                        .font(.headline)
                        .foregroundColor(Color.black)
                    Text("by \(course.instructorName)") // to be updated
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("76%")
                        .font(.caption)
                        .bold()
                    ProgressBar(value: 0.8)
                        .frame(height: 5)
                }
                Spacer()
            }
            .frame(width: .infinity, height: 100)
            .background(Color("color 3"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(100), lineWidth: 0.2)
            )
        }
    }
}

struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color("color 4"))
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("color 2"))
            }
            .cornerRadius(45.0)
        }
    }
}

struct MyCourses_Previews: PreviewProvider {
    static var previews: some View {
        MyCourses()
    }
}
