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
    
    var course : Course
    var body: some View {
        NavigationView{
            VStack {
                // Header Image and Title
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string: course.imageName)) { phase in
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
                        
                    
                    Text(course.title)
                        .font(.custom("Poppins-Bold", size: 20))
                        .padding(.leading,20)
                    
                    Text("Created by \(course.instructorName)")
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
                        LecturesView(course: course)
                    } else {
                        ResourcesView()
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    struct LecturesView: View {
        
        @State var course : Course
        @State var modules: [Module] = []
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(modules, id: \.id) { module in
                    SectionsView(title: module.title, items: [(module.videoFileName, module.notesFileName)], iconNames: ["play.circle", "play.circle"])
//                    LectureCardView(module: module)
                    Divider()
                }
            }
            .onAppear() {
                allModules()
            }
            .padding()
        }
        
        func allModules() {
            FirebaseServices.shared.fetchModules(course: course) { modules in
                self.modules = modules
                print("Self Modules : ",self.modules)
            }
        }
    }
    
    struct LectureCardView : View {
        var module : Module
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                SectionsView(title: module.title, items: [(module.videoFileName, module.notesFileName)], iconNames: ["play.circle", "play.circle"])
                Divider()
            }
            .padding()
        }
    }
    
    struct ResourcesView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ResourceItem(title: "Notes", icon: "doc.text").accessibilityElement(children: .ignore)
                    .accessibilityLabel("Notes").accessibilityHint("click here to download notes of this course")
                Divider()
                NavigationLink(destination: QuizView()) {
                    ResourceItem(title: "Quiz", icon: "questionmark.circle").foregroundColor(.black).accessibilityElement(children: .ignore)
                        .accessibilityLabel("Quiz").accessibilityHint("click here to give the quiz")
                }
                Divider()
                ResourceItem(title: "Certificate", icon: "rosette").accessibilityElement(children: .ignore)
                    .accessibilityLabel("Certificate").accessibilityHint("click here to download the certificate")
                Divider()
                NavigationLink(destination: Chatview()){
                    ResourceItem(title: "Discuss", icon: "message").foregroundColor(.black).accessibilityElement(children: .ignore)
                    .accessibilityLabel("Discuss Forum").accessibilityHint("click here to disscuss anything about this course with your peers")}
                Divider()
            }
            .padding()
        }
    }
    
    
    
    struct SectionsView: View {
        let title: String
        let items: [(String?, String?)]
        let iconNames: [String]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .padding(.top)
                ForEach(0..<items.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(items[index].0!)
                            Spacer()
                            Image(systemName: iconNames[index])
                        }
                        Text(items[index].1!)
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
        NodeJsCourseView(course: Course())
    }
}
