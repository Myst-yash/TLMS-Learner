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

                ProgressView()
                    .tabItem {
                        Label("Progress", systemImage: "chart.bar.fill")
                    }
                    .tag(1) // Tag for CoursesView

                ProfileView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Educators")
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
/*
struct ContentView1: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationStack {
                ProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .navigationBarBackButtonHidden()
    }
}
*/

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
        let selectedColor = UIColor(hex: "#6C5DD4")!
        let normalColor = UIColor(hex: "#6C5DD4")!.withAlphaComponent(0.5)

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
