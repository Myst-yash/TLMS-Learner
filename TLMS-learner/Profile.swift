//
//  Profile.swift
//  TLMS-learner
//
//  Created by Abid Ali on 08/07/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileViews: View {
    @State private var user: User = User(id: "", email: "", firstName: "", lastName: "", completedCourses: [""], enrolledCourses: [""], goal: "", joinedDate: "", likedCourses: [""])
    @State private var showSettings = false
    @State private var isSignedOut = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ProfileHeader(user: user, showSettings: $showSettings)
                    DashboardView(enrolledCourses: user.enrolledCourses.count, completedCourses: user.completedCourses.count)
                    CourseActionsView()
//                    LikedCoursesView(likedCourses: user.likedCourses)
                }
                .padding()
                .onAppear(perform: {
                    FirebaseServices.shared.fetchProfileDetails { fetchedUser in
                        if let fetchedUser = fetchedUser{
                            self.user = fetchedUser
                        }
                        else{
                            print("error hai bhai")
                        }
                    }
                })
            }
            .background(Color(UIColor.white))
            .sheet(isPresented: $showSettings) {
                SettingsView(isSignedOut: $isSignedOut)
            }
        }
        .background(
            NavigationLink(destination: ContentView(), isActive: $isSignedOut) {
                EmptyView()
            }
        )
    }
}

struct ProfileHeader: View {
    let user: User
    @Binding var showSettings: Bool

    var body: some View {
        HStack {
            Text("Profile")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: { showSettings = true }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.blue)
            }
        }

        VStack(alignment: .leading) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.purple).padding(.leading, 150)

            Text("\(user.firstName) \(user.lastName)")
                .font(.title2)
                .fontWeight(.semibold).padding(.leading, 130)
            Text("Joined \(user.joinedDate)")
                .font(.subheadline)
                .foregroundColor(.secondary).padding(.leading, 110)
            Text("Student")
                .font(.caption)
                .foregroundColor(.secondary).padding(.leading, 160)
        }
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

                VStack(alignment: .leading) {
                    HStack {
                        Text("Enrolled Courses")
                        Spacer()
                        Text("\(enrolledCourses)")
                            .fontWeight(.bold)
                    }.padding(.leading, 20).padding(.bottom, 10)
                    HStack {
                        Text("Completed Courses")
                        Spacer()
                        Text("\(completedCourses)")
                            .fontWeight(.bold)
                    }.padding(.leading, 20)
                }
            }.frame(width: 330, height: 140)
            .padding()
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
                .foregroundColor(.purple)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: completedPercentage)
        }
    }
}

struct CourseActionsView: View {
    var body: some View {
        HStack {
            Button(action: {}) {

                VStack {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Enrolled Courses")
                        .font(.headline).foregroundStyle(.black).padding(.top, 40)
                }
            }
            .frame(width: 150, height: 130)
            .padding()
            .background(Color.white)
            .cornerRadius(25).overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("color 6"), lineWidth: 1)
            )
            Button(action: {}) {
                VStack {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Certificates")
                        .font(.headline).foregroundStyle(.black).padding(.top, 40)
                }
            }
            .frame(width: 150, height: 130)
            .padding()
            .background(Color.white)
            .cornerRadius(25).overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("color 6"), lineWidth: 1)
            )
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

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isSignedOut: Bool

    var body: some View {
        VStack {
            Text("Settings")
            Button(action: {
                signOut()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Sign Out")
                    .foregroundColor(.blue)
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

struct Courses: Identifiable {
    let id = UUID()
    let name: String
    let instructor: String
}

// Preview
//struct ContentViews_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileViews()
//    }
//}



//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue: Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}

