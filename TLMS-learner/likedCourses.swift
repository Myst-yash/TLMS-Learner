//
//  likedCourses.swift
//  TLMS-learner
//
//  Created by Abid Ali    on 16/07/24.
//

import Foundation
import SwiftUI

struct LikedView: View {
    var body: some View {
            VStack {
                
                

                // List of liked courses
                List {
                    ForEach(0..<5) { _ in
                        NavigationLink(destination: Text("Course Details")) {
                            likedCourseRow()
                        }
                    }
                }
                
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Liked Courses", displayMode: .large)
    }
}

struct likedCourseRow: View {
    var body: some View {
        HStack {
            Image("batman")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("Django se Panga")
                    .font(.headline)
                Text("Batman")
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

