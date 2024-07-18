import SwiftUI
import FirebaseAuth

struct ProfileViews: View {
    @State private var user: User = User(id: "", email: "", firstName: "", lastName: "", completedCourses: [""], enrolledCourses: [""], goal: "", joinedDate: "", likedCourses: [""])
    @State private var showSettings = false
    @State private var isSignedOut = false
    @State private var profileImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ProfileHeader(user: user, showSettings: $showSettings, profileImage: $profileImage)
                        DashboardView(enrolledCourses: user.enrolledCourses.count, completedCourses: user.completedCourses.count)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            NavigationLink(destination: EducatorView()) {
                                ListItemView(systemName: "person", text: "Your Educators", color: .black).accessibilityLabel("Your Educators")
                                    .accessibilityHint("You can see the list of your educators by clicking this")
                            }.accessibilityLabel("Your Educators")
                                .accessibilityHint("You can see the list of your educators here")
                            Divider()
                            NavigationLink(destination: LikedView()) {
                                ListItemView(systemName: "heart", text: "Your Wishlist", color: .black)
                            }.accessibilityHint("You can see your liked courses here")
                            Divider()
                            NavigationLink(destination: Certificate()) {
                                ListItemView(systemName: "doc", text: "Your Certificates", color: .black)
                            }.accessibilityHint("You can see your earned certificates here")
                            Divider()
                            NavigationLink(destination: ChangePassword()) {
                                ListItemView(systemName: "lock", text: "Change Password", color: .black)
                            }.accessibilityHint("You can change your password here")
                            Divider()
                            Button(action: {
                                signOut()
                            }) {
                                ListItemView(systemName: "power", text: "Log out", color: .red)
                            }
                        }
                        .padding()
                        .padding(.leading, -20)
                        .padding(.top, -20)
                    }
                    .padding()
                    .onAppear(perform: {
                        FirebaseServices.shared.fetchProfileDetails { fetchedUser in
                            if let fetchedUser = fetchedUser {
                                self.user = fetchedUser
                            } else {
                                print("Error fetching user data")
                            }
                        }
                    })
                }
                .background(Color(UIColor.white))
                .sheet(isPresented: $showSettings) {
                    // Add settings view content here
                }
                .fullScreenCover(isPresented: $isSignedOut) {
                    ContentView()
                }
            }
        }
    }


    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedOut = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


struct ProfileHeader: View {
    let user: User
    @Binding var showSettings: Bool
    @Binding var profileImage: UIImage?
    @State private var showEditProfile = false
    @State private var showImagePicker = false
    
    var body: some View {
//        HStack {
//            Text("Profile")
//                .font(.title)
//                .fontWeight(.bold)
//            Spacer()
////            Button(action: { showSettings = true }) {
////                Image(systemName: "gearshape")
////                    .foregroundColor(.blue)
////            }
//        }
        VStack{
            Button(action: {
                showEditProfile = true
                showImagePicker = true
            }) {
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .padding(.top)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color("color 2"))
                        .padding(.top)
                        .accessibilityLabel("Profile Picture")
                        .accessibilityHint("You can click on it to change your profile picture")
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profileImage)
            }

            Text("\(user.firstName) \(user.lastName)")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Joined \(user.joinedDate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Student")
                .font(.caption)
                .foregroundColor(.secondary)
        
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.automatic)
        }.padding(.leading, 120)
            
    }
}


struct DashboardView: View {
    let enrolledCourses: Int
    let completedCourses: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dashboard")
                .font(.headline)

            HStack {
                PieChartView(completedPercentage: Float(completedCourses) / Float(enrolledCourses))
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
             Spacer()
                    VStack(alignment: .leading) {
                        
                        Text("Enrolled Courses").accessibilityLabel("You have enrolled in \(enrolledCourses) courses")
                            
                            Text("\(enrolledCourses)")
                                .fontWeight(.bold)
                        
                            Text("Completed Courses").accessibilityLabel("You have completed \(enrolledCourses) courses")
                            
                            Text("\(completedCourses)")
                                .fontWeight(.bold)
                    }
            }.frame(width: 330, height: 140)
            .padding(20)
            .background(Color("color 7"))
            .cornerRadius(25).overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 0.5)
            )
        }
    }
}

struct PieChartView: View {
    let completedPercentage: Float

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(.purple)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.completedPercentage, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("color 2"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: completedPercentage)
        }
    }
}
struct LikedCoursesView: View {
    let likedCourses: [Courses]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Liked")
                    .font(.headline)
                Spacer()
                Button("See All") {}
                    .foregroundColor(.blue)
            }

            ForEach(likedCourses) { course in
                Button(action: {}) {
                    HStack {
                        Image("django_logo") // Assume you have this image in your assets
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(course.name)
                                .font(.headline).foregroundStyle(.black)
                            Text("by \(course.instructor)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color("color 7"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("color 6"), lineWidth: 0.1)
                    ).shadow(radius: 1)
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}


struct Courses: Identifiable {
    let id = UUID()
    let name: String
    let instructor: String
}

// Preview
struct ContentViews_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViews()
    }
}
struct ListItemView: View {
    let systemName: String
    let text: String
    let color: Color
    let backgroundColor: Color?
    
    init(systemName: String, text: String, color: Color, backgroundColor: Color? = nil) {
        self.systemName = systemName
        self.text = text
        self.color = color
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(color)
            Text(text)
                .foregroundColor(color)
                .font(.system(size: 18))
            Spacer()
        }
        .padding()
        .background(backgroundColor ?? Color.clear)
        .cornerRadius(10)
    }
}

// Placeholder views for navigation
struct FavoritesView: View {
    var body: some View {
        Text("You have not enrolled in any course")
            .font(.largeTitle)
    }
}

struct TellYourFriendView: View {
    var body: some View {
        Text("Nothing in Wishlist")
            .font(.largeTitle)
    }
}

struct PromotionsView: View {
    var body: some View {
        Text("Promotions")
            .font(.largeTitle)
    }
}

struct SettingView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
    }
}

struct LogoutView: View {
    var body: some View {
        Text("Log out")
            .font(.largeTitle)
    }
}

struct Certificate:View{
    var body: some View{
        Text("You don't have any certificates")
    }
}
