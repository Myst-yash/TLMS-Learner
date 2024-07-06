import SwiftUI
struct CourseCategoriesView: View {
    @State private var selectedCategories = Set<UUID>()
    @State private var navigateNext = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 20) {
                HeadingLabel(text: "Select Your Goal!",fontSize: 30)
                
                Text("Select your area of interest you want to learn")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(CourseCategory.courseCategories) { category in
                        Button(action: {
                            if selectedCategories.contains(category.id) {
                                selectedCategories.remove(category.id)
                            } else {
                                selectedCategories.removeAll()
                                selectedCategories.insert(category.id)
                            }
                        }) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(selectedCategories.contains(category.id) ? Color.purple : Color.white)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Circle()
                                                .stroke(selectedCategories.contains(category.id) ? Color.clear : Color.black, lineWidth: 1)
                                        )
                                    
                                    if selectedCategories.contains(category.id) {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .frame(width: 10, height: 8)
                                            .foregroundColor(.white)
                                    }
                                }
                                Text(category.name)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedCategories.contains(category.id) ? Color.purple.opacity(0.4) : Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedCategories.contains(category.id) ? Color.clear : Color.black, lineWidth: 1)
                            )
                        }
                    }
                }
                
                
                    CustomButton(label: "Continue",action: {
                        navigateNext = true
                    })
                // here the SignupView() will be replaced by HomeView()
                // placed as it was blocking the preview #sumit-prd
                NavigationLink(destination: SignupView(), isActive: $navigateNext) {
                               EmptyView()
                           }
                
            }
        
            .padding()
            .navigationBarBackButtonHidden()
        }
    }


struct CourseCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCategoriesView()
    }
}
struct SignupView: View {
    var body: some View {
        Text("Signup View")
            .navigationBarHidden(true)
    }
}



func updateGoal(){
    // the updation of the goal of the a particular user will be done here
}
