import SwiftUI


struct ContentView1: View {
    @State private var selectedTabIndex = 1 // Default to CoursesView (index 1)

    var body: some View {
        VStack {
            CustomTabBarAppearance() // Apply custom tab bar appearance
                .frame(height: 0) // Hide the actual tab bar
                .hidden()

            TabView(selection: $selectedTabIndex) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0) // Tag for NotificationView

                MyCourses()
                    .tabItem {
                        Label("My Courses", systemImage: "book.fill")
                    }
                    .tag(1) // Tag for CoursesView

                ProfileViews()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2) // Tag for ProfileView
            }
            .onAppear {
                selectedTabIndex = 0 // Set CoursesView as default on screen appear
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}


struct CustomTabBarAppearance: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white

        // Customize tab bar item colors
        let itemAppearance = UITabBarItemAppearance()
        let selectedColor = UIColor(Color("color 2"))
        let normalColor = UIColor(Color("color 2")).withAlphaComponent(0.5)

        itemAppearance.normal.iconColor = normalColor
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
        itemAppearance.selected.iconColor = selectedColor
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        tabBarAppearance.stackedLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No update needed
    }
}
