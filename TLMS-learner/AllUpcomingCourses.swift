//
//  AllPopularCourses.swift
//  TLMS-learner
//
//  Created by Abid Ali    on 19/07/24.
//



import Foundation
import SwiftUI

struct AllUpcomingCoursesView: View {
    @State var course = [HomeCourse]()
    var body: some View {
            VStack {
                List(course) { course in
                    likedCourseRow(imageURL: course.courseImage, courseName: course.courseName,educatorName: course.assignedEducator)
                }
                
                .listStyle(PlainListStyle())
                .navigationBarTitle("Upcoming Courses", displayMode: .large)
            }

    }
}

struct UpcomingCourseRow: View {
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

struct UpcomingCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AllUpcomingCoursesView()
    }
}




