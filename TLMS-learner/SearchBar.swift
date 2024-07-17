//
//  SearchBar.swift
//  TLMS-learner
//
//  Created by Mac on 11/07/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @State private var searchText: String = ""
    @Environment(\.presentationMode) var presentationMode
    var courses: [HomeCourse]
    
    var filteredCourses: [HomeCourse] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { course in
                course.courseName.lowercased().contains(searchText.lowercased()) ||
                course.assignedEducator.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                TextField("Search Courses", text: $searchText)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 30)
                    .background(Color(.white))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss() // Go back
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.blue)
                                    .padding(.leading, 10)
                            }
                            
                            Spacer()
                            if !searchText.isEmpty {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                            }
                        }
                    )
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
            .compositingGroup()
            .shadow(color: .gray, radius: 3)
            .padding(.bottom, 0)
            .navigationBarBackButtonHidden()
            
            if filteredCourses.isEmpty {
                VStack {
                    Text("Uh-oh! No results found 😢")
                        .opacity(0.5)
                        .font(.headline)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(filteredCourses) { course in
                    HStack {
                        AsyncImage(url: URL(string: course.courseImage)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120)
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120)
                                    .clipped()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(course.courseName)
                                .font(.headline)
                            Text("by \(course.assignedEducator)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            // Action for the arrow button
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 0)
                }
            }
        }
    }
}

#Preview{
    SearchBar(courses: [])
}
