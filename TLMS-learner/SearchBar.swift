//
//  SearchBar.swift
//  TLMS-learner
//
//  Created by Mac on 11/07/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @State var searchText: String = ""
    @Environment(\.presentationMode) var presentationMode
    var courses: [Course] {
        popularCourses + recommendedCourses
    }
    var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { course in
                course.title.lowercased().contains(searchText.lowercased()) ||
                course.instructorName.lowercased().contains(searchText.lowercased())
                
            }
        }
    }
    
    var body: some View {
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
                    Image("\(course.imageName)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .clipped()
                    VStack(alignment: .leading) {
                        Text(course.title)
                            .font(.headline)
                        Text("by \(course.instructorName)")
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

#Preview{
    SearchBar()
}
