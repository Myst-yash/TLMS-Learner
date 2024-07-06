//
//  MyCourses.swift
//  TLMS-learner
//
//  Created by Sumit Prasad on 06/07/24.
//
import SwiftUI

struct Video: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let progress: Double
}

let videosArray1: [Video] = [
    Video(title: "Django se Panga", author: "Batman", progress: 0.75),
    // Add more videos
]

let videosArray2: [Video] = [
    Video(title: "Python Basics", author: "Superman", progress: 0.50),
    // Add more videos
]


struct MyCourses: View {
    @State private var selectedSegment = 0
    let segments = ["Ongoing", "Completed"]
    
    
    init() {
    // Sets the background color of the Picker
       UISegmentedControl.appearance().backgroundColor = .purple.withAlphaComponent(0.15)
    // Disappears the divider
       UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    // Changes the color for the selected item
       UISegmentedControl.appearance().selectedSegmentTintColor = .purple
    // Changes the text color for the selected item
       UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack {
            Picker("Segments", selection: $selectedSegment) {
                //two segments
                ForEach(0..<2) { index in
                    Text(segments[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            
            // the listing of the courses according to the selected segment
            List {
                ForEach(selectedSegment == 0 ? videosArray1 : videosArray2) { video in
                    HStack {
                        Image(systemName: "play.rectangle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .background(Color.black)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(video.title)
                                .font(.headline)
                            Text("by \(video.author)")
                                .font(.subheadline)
                            ProgressView(value: video.progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
            }
            .background(Color.gray.opacity(0.1))
        }
    }
}

#Preview {
    MyCourses()
}
