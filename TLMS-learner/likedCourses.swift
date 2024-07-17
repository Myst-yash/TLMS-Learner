//
//  likedCourses.swift
//  TLMS-learner
//
//  Created by Abid Ali    on 16/07/24.
//

import Foundation
import SwiftUI

struct LikedView: View {
    @State var allLikedCourse = [Course]()
    var body: some View {
            VStack {
                List(allLikedCourse) { course in
                    NavigationLink(destination: CourseDetails(courseId: course.id)) {
                        likedCourseRow(imageURL: course.imageName, courseName: course.title,educatorName: course.instructorName)
                    }
                }
                
                .listStyle(PlainListStyle())
                .navigationBarTitle("Liked Courses", displayMode: .large)
            }
            
            .onAppear {
                Task {
                    do {
                        let courses = try await FirebaseServices.shared.fetchAllLikedCourses()
                        self.allLikedCourse = courses
//                        print(self.allLikedCourse)
                    } catch {
                        // Handle the error appropriately
                        print("Error fetching liked courses: \(error)")
                        // Optionally show an alert or handle error in UI
                    }
                }
            }

    }
}

struct likedCourseRow: View {
    var imageURL:String
    var courseName:String
    var educatorName:String
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.1)) // Placeholder background
                    .frame(width: 100, height: 60)
                    .cornerRadius(10)
                
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 60) // Ensure ProgressView takes the same space
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 60)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 60)
                            .cornerRadius(10)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
                
            VStack(alignment: .leading) {
                Text(courseName)
                    .font(.headline)
                Text(educatorName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
//            Image(systemName: "chevron.right")
//                .foregroundColor(.blue)
        }
        .padding(.vertical, 8)
    }
}

struct CoontentView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
    }
}

