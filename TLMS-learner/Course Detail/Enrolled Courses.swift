//
//  Enrolled Courses.swift
//  TLMS-learner
//
//  Created by Mac on 12/07/24.
//

import Foundation
import SwiftUI

struct NodeJsCourseView: View {
    
    @State private var selectedSegment = 0
    
    var courseName:String
    var courseImage:String
    var body: some View {
        NavigationView{
            VStack {
                // Header Image and Title
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string: courseImage)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal,10)
                        case .failure:
                            ProgressView()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                        
                    
                    Text(courseName)
                        .font(.custom("Poppins-Bold", size: 20))
                        .padding(.leading,20)
                    
                    Text("Created by Vasooli Bhai")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading,20)
                }
                
                // Segmented Control
                Picker("", selection: $selectedSegment) {
                    Text("Lectures").tag(0)
                    Text("Resources").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // ScrollView Content
                ScrollView {
                    if selectedSegment == 0 {
                        LecturesView()
                    } else {
                        ResourcesView()
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    struct LecturesView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                SectionsView(title: "Section 1 - Introduction", items: [
                    ("Introduction to the course", "10 mins")
                ], iconNames: ["play.circle"])
                Divider()
                SectionsView(title: "Section 2 - Basics of Node Js", items: [
                    ("Basics of Node Js", "10 mins"),
                    ("Fundamentals", "10 mins"),
                    ("Assignment", "10 mins")
                ], iconNames: ["play.circle", "play.circle", "exclamationmark.circle"])
                Divider()
                
                SectionsView(title: "Section 3 - APIs", items: [
                    ("API Basics", "10 mins"),
                    ("Building APIs", "10 mins")
                ], iconNames: ["play.circle", "play.circle"])
                Divider()
            }
            .padding()
        }
    }
    
    struct ResourcesView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ResourceItem(title: "Notes", icon: "doc.text")
                Divider()
                NavigationLink(destination: QuizView()) {
                    ResourceItem(title: "Quiz", icon: "questionmark.circle").foregroundColor(.black)
                }
                Divider()
                ResourceItem(title: "Certificate", icon: "rosette")
                Divider()
                ResourceItem(title: "Discuss", icon: "message")
                Divider()
            }
            .padding()
        }
    }
    
    
    
    struct SectionsView: View {
        let title: String
        let items: [(String, String)]
        let iconNames: [String]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .padding(.top)
                ForEach(0..<items.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(items[index].0)
                            Spacer()
                            Image(systemName: iconNames[index])
                        }
                        Text(items[index].1)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
    
    struct ResourceItem: View {
        let title: String
        let icon: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                VStack(alignment: .leading) {
                    Text(title)
                    Text("Description") // Add description if needed
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
        }
    }
}
struct NodeJsCourseView_Previews: PreviewProvider {
    static var previews: some View {
        // for proper preview provide some image url from remote
        NodeJsCourseView(courseName: "test", courseImage: "")
    }
}
