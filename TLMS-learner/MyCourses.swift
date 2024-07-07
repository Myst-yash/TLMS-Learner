import SwiftUI

struct MyCourses: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSegment = 0
    let segments = ["Ongoing", "Completed"]
    
    
    var body: some View {
        VStack {
            Picker("Segments", selection: $selectedSegment) {
                ForEach(0..<segments.count, id: \.self) { index in
                    Text(segments[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            .padding()
            
            List(selectedSegment == 0 ? popularCourses : recommendedCourses) { course in
                HStack {
                    Image(course.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(course.title)
                            .font(.headline)
                        Text("by \(course.instructor)")
                            .font(.subheadline)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
            }
            .background(Color.gray.opacity(0.1))
        }
        .navigationTitle("My Courses")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Home")
            }
        })
    }
}

struct MyCourses_Previews: PreviewProvider {
    static var previews: some View {
        MyCourses()
    }
}
