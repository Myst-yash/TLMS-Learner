import Foundation
import SwiftUI
import AVKit

struct NodeJsCourseView: View {
    
    @State private var selectedSegment = 0
    @State private var selectedVideo: Video?
    
    var courseName: String
    var courseImage: String
    
    var body: some View {
        NavigationView {
            VStack {
                // Header Image and Title
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: courseImage)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 10)
                        case .failure:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(courseName)
                        .font(.custom("Poppins-Bold", size: 20))
                        .padding(.leading, 20)
                    
                    Text("Created by Sir ")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
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
                        LecturesView(selectedVideo: $selectedVideo)
                    } else {
                        ResourcesView()
                    }
                }
            }
            .navigationBarTitle(courseName, displayMode: .inline)
            .sheet(item: $selectedVideo) { video in
                VideoPlayer(player: AVPlayer(url: video.url))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            }
        }
    }
    
    struct LecturesView: View {
        @Binding var selectedVideo: Video?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                SectionsView(title: "Section 1 - Introduction", items: [
                    ("Introduction to the course", "10 mins", "interiAR.mp4")
                ], iconNames: ["play.circle"], selectedVideo: $selectedVideo)
                Divider()
                SectionsView(title: "Section 2 - Basics of Git", items: [
                    ("Basics of Git", "10 mins", "interiAR_Garden.mp4"),
                    ("Fundamentals", "10 mins", "interiAR.mp4"),
                    ("Assignment", "10 mins", "RPReplay_Final1718084690.mov")
                ], iconNames: ["play.circle", "play.circle", "exclamationmark.circle"], selectedVideo: $selectedVideo)
                Divider()
                
                SectionsView(title: "Section 3 - APIs", items: [
                    ("API Basics", "10 mins", "master.mp4"),
                    ("Building APIs", "10 mins", "interiAR_Garden.mp4")
                ], iconNames: ["play.circle", "play.circle"], selectedVideo: $selectedVideo)
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
                NavigationLink(destination: Chatview()) {
                    ResourceItem(title: "Discuss", icon: "message").foregroundColor(.black)
                }
                
                Divider()
            }
            .padding()
        }
    }
    
    struct SectionsView: View {
        let title: String
        let items: [(String, String, String)]
        let iconNames: [String]
        @Binding var selectedVideo: Video?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .padding(.top)
                ForEach(0..<items.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: {
                                let baseURL = URL(string: "http://172.20.5.118/videos/")!
                                let url = baseURL.appendingPathComponent(items[index].2)
                                selectedVideo = Video(name: items[index].0, url: url)
                            }) {
                                HStack {
                                    Text(items[index].0)
                                    Spacer()
                                    Image(systemName: iconNames[index])
                                }
                            }
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

struct Video: Identifiable {
    var id: String { name }
    let name: String
    let url: URL
}


