import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hi, Abid 👋")
                        .font(.largeTitle)
                        .padding(.top, 20)
                    
                    Text("Start learning!")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    SearchBar()
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("Continue Watching")
                            .font(.headline)
                        Spacer()
                        NavigationLink(destination: MyCourses()) {
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    Image("swift")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .cornerRadius(10)
                    
                    HStack {
                        Text("Popular Courses")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // Action for "See All"
                        }) {
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(popularCourses) { course in
                                PopularCourseCard(course: course)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    HStack {
                        Text("For you")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // Action for "See All"
                        }) {
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        
                        HStack(spacing: 15) {
                            ForEach(recommendedCourses) { course in
                                CourseCard(course: course)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct SearchBar: View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            Button(action: {
                // Action for voice search
            }) {
                Image(systemName: "mic.fill")
                    .padding(.trailing, 10)
            }
        }
    }
}

struct PopularCourseCard: View {
    let course: Course
    var body: some View {
        VStack(alignment: .leading) {
            Image(course.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 265, height: 110)
                .cornerRadius(15)
            
            Text(course.title)
                .font(.headline)
                .padding(.top, -5)
                .padding(.leading, 6 )
            
            Text("by \(course.instructor)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading, 6 )
                .padding(.top, 0)
        }
        .frame(width: 250, height: 150)
        .padding()
        .background(Color(hex:"#F7F7FC"))
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 0.1)).shadow(radius: 5)
        .padding(.bottom , 10).padding(.top, 10)
    }
}


struct CourseCard: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading) {
            Image(course.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 100)
                .clipped()
                .cornerRadius(10)
            
                
                Text(course.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("by \(course.instructor)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            
        }
        .frame(width: 150)
    }
}

struct ProgressView: View {
    var body: some View {
        Text("Progress View")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
    }
}
