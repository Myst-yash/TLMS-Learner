import SwiftUI
import FirebaseAuth

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var selectedGoal: String = ""
    @State private var showDropdown: Bool = false
    @State var goals: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                HStack() {
                    Text(selectedGoal)
                        .font(.headline)
                        .frame(width: 150)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        showDropdown.toggle()
                    }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                .background(Color(.white))
                .cornerRadius(8)
                .lineLimit(1)

                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Popular Courses")
                                .font(.title2).bold()
                            Spacer()
                            Button(action: {
                                // Action for "See All"
                            }) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<5) { _ in
                                    Button(action: {
                                        // Add your action here
                                        print("PopularCoursesCard tapped")
                                    }) {
                                        PopularCoursesCard()
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.leading, 20)
                        }

                           

                        HStack {
                            Text("For You")
                                .font(.title2).bold()
                            Spacer()
                            NavigationLink(destination: MyCourses()) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<5) { _ in
                                    Button(action: {
                                        // Add your action here
                                        print("ContinueWatchingCard tapped")
                                    }) {
                                        ContinueWatchingCard()
                                    }
                                    .buttonStyle(PlainButtonStyle()) // Ensures no default button styling is applied
                                }
                            }
                            .padding(.leading, 20)
                        
                        }

                        HStack {
                            Text("Upcoming Courses")
                                .font(.title2).bold()
                            Spacer()
                            Button(action: {
                                // Action for "See All"
                            }) {
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            VStack(spacing: -10) {
                                ForEach(0..<5) { _ in
                                    UpcomingCourseCard()
                                }
                            }
                            .padding(.leading, 30)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $showDropdown) {
                VStack {
                    Text("My goals")
                        .font(.headline)
                        .padding()
                    
                    Divider()
                    
                    ForEach(goals, id: \.self) { goal in
                        Button(action: {
                            selectedGoal = goal
                            showDropdown = false
                            updateGoal(newData: goal)
                            
                        }) {
                            HStack {
                                Text(goal)
                                Spacer()
                                if goal == selectedGoal {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("color 2"))
                                }
                            }
                            .padding()
                        }
                        .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showDropdown = false
                    }) {
                        Text("Close")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("color 2"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .background(Color(.systemGray6))
                .onAppear {
                    FirebaseServices.shared.fetchTargets { fetchedTargets in
                        self.goals = fetchedTargets
                        print(fetchedTargets)
                    }
                }
            }
            .onAppear {
                FirebaseServices.shared.findSelectedGoal { userGoal in
                    self.selectedGoal = userGoal
                }
            }
        }
    }
    
    func updateGoal(newData:String){
        FirebaseServices.shared.updateSelectedGoasl(newData: newData) { success in
            if success {
                print("Goal updated")
            }
            else{
                print("there is an issue with it")
            }
        }
    }
}


struct SearchBar: View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            Button(action: {
                // Action for voice search
            }) {
                Image(systemName: "mic.fill")
                    .padding(.trailing, 10)
            }
        }
    }
}
struct ContinueWatchingCard: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Image("batman")
            Image("glass")
            Image("glassCart").padding(.top, 90)
            
                Text("Get started\n with Git").foregroundStyle(Color.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding().padding(.top, 85)
                
            Image("edu").padding(.top, 100).padding(.leading, 210)
            Text("Batman").font(.footnote).bold().foregroundStyle(.white).padding(.top, 100).padding(.leading, 225)
            Image("heart").padding(.bottom, 100).padding(.leading, 260)
                
            
            
            
            
            
        }
    }
}

struct PopularCoursesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                VStack{
                    Image("swift").resizable().frame(width: 356,height: 160)
                    Text("All about Swift").font(.title3).bold().padding(.leading, -155).padding(.top, 5).fontWeight(.semibold)
                    Text("by batman").padding(.leading, -154).font(.subheadline).foregroundColor(.gray)
                    
                }
                
            }
        }
    }
}
struct UpcomingCourseCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            
            
                HStack {
                    Image("django")
                        .resizable()
                        .frame(width: 140, height: 80)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Django se Panga")
                            .font(.headline)
                        Text("by batman")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("24/09/2025")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.leading, 10)
                Divider()
            
            
        }
        .padding().padding(.leading, -40).padding(.top, -20)
    }
}



struct ProfileView: View {
    var body: some View {
        Text("Profile View")
    }
}

#Preview {
    HomeView()
}
