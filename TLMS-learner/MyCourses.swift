import SwiftUI

struct MyCourses: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSegment = 0
    let segments = ["Ongoing", "Completed"]
    
    /*
    init() {
        // Sets the background color of the Picker
        UISegmentedControl.appearance().backgroundColor = UIColor.purple.withAlphaComponent(0.15)
        // Disappears the divider
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        // Changes the color for the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.purple
        // Changes the text color for the selected item
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        // Customize the navigation bar appearance
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    */
    
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
                ZStack(alignment: .center){
                    PNGImageView(imageName: course.imageName, width: 354, height: 150)
                    RoundedRectangle(cornerRadius: 12)
                        .fill( LinearGradient(
                            gradient: Gradient(colors: [.red, .purple]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.1)
                    
                }
//                HStack {
//                    Image(course.imageName)
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .cornerRadius(8)
//                    Spacer()
//                    VStack(alignment: .leading) {
//                        Text(course.title)
//                            .font(.headline)
//                        Text("by \(course.instructor)")
//                            .font(.subheadline)
//                    }
//                }
//                .padding()
//                .background(Color.white)
//                .cornerRadius(12)
//                .shadow(radius: 2)
            }
            .background(Color.gray.opacity(0.1))
        }
        .navigationTitle("My Courses")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "chevron.left")
//                Text("Home")
//            }
//        })
    }
}

struct MyCourses_Previews: PreviewProvider {
    static var previews: some View {
        MyCourses()
    }
}
