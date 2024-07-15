import SwiftUI

struct MyCourses: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSegment = 0
    let segments = ["Ongoing", "Completed"]
    
    init() {
       
        //      Sets the background color of the Picker
        UISegmentedControl.appearance().backgroundColor = UIColor(named: "#FAFAFA")
        //      Disappears the divider
             UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        //      Changes the color for the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "color 2")
        //      Changes the text color for the selected item
             UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
             
        //      Customize the navigation bar appearance
             UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
             UINavigationBar.appearance().shadowImage = UIImage()
             UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            segmentControl
                .padding(.top, 10)
                .padding(.horizontal)
                .background(Color.white)
            
            ScrollView {
                VStack {
                    ForEach(0..<4) { _ in
                        ForYouCourseCard()
                    }
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle("My Courses")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var segmentControl: some View {
        Picker("Segments", selection: $selectedSegment) {
            ForEach(0..<segments.count, id: \.self) { index in
                Text(segments[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}


struct ForYouCourseCard: View {
    var body: some View {
        Button(action: {}){
            HStack {
                Image("nodejs").resizable().frame(width: 149, height: 86).cornerRadius(8).padding(.leading, 6)
                
                VStack(alignment: .leading) {
                    Text("Django se Panga")
                        .font(.headline).foregroundStyle(Color.black)
                    Text("by Batman")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("76%").font(.caption).bold()
                    ProgressBar(value: 0.8).frame(height: 5)
                }
                Spacer()
            }.frame(width: 359, height: 100).background(Color("color 3"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(100), lineWidth: 0.2))
                
        }
    }
}
struct ProgressBar: View {
    var value: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color("color 4"))

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("color 2"))
            }
            .cornerRadius(45.0)
        }
    }
}
struct MyCourses_Previews: PreviewProvider {
    static var previews: some View {
        MyCourses()
    }
}
