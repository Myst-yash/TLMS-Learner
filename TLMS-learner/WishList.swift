import SwiftUI


struct EducatorListView : View {
    @State private var check = false
    @State private var selectedSegment = 0
    private let segments = ["Educators", "Learners"]
    var courses : [Course] = [
    var educator : Educator = Educator(firstName: "Fahar", lastName: "Imran", about: "this is howe we do it there is no other way ", email: "fahar123@gmail.com", password: "Fahar@123", phoneNumber: "9809874564", profileImageURL: "")
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var body: some View {
        NavigationView{
            VStack () {
                Picker("Select Segment", selection: $selectedSegment) {
                    ForEach(0..<segments.count) { index in
                        Text(segments[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedSegment == 0 {
                    GeometryReader { geometry in
                        ScrollView{
                            VStack(spacing: 5){
                                if firebaseFetch.educators.isEmpty {
                                    Text("No Educators")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.black))
                                        .opacity(0)
                                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4)
                                } else {
                                    ForEach(firebaseFetch.educators){ educator in
                                        EducatorsListCard(educator: educator)
                                    }.frame(width: 354, height: 100)
                                        .background(Color("color 3"))
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                                        .padding(10)
                                    .onAppear(){
                                        print(firebaseFetch.educators)
                                    }
                                }
                            }
//
                        }.padding(10)
                        
                    }
                } else if  selectedSegment == 1 {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(courses) { course in
                                UpdateCardView(course: course, educator: educator)
                            }
                        }
                        .frame(width: 354, height: 100)
                        .background(Color("color 3"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                        .padding(10)
                    }
                    
                    
                    
                }
                }
                    .onAppear() {
                        firebaseFetch.fetchEducators()
                    }
                    .navigationTitle("Educators")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    
    
    
    
    struct EducatorsListCard: View {
        
        @ObservedObject var firebaseFetch = FirebaseFetch()
        
        var educator : Educator
        
        var body: some View {
            NavigationLink(destination: EducatorProfile()){
                HStack(spacing: 10){
//                    ZStack{
                    EducatorProfileImage(imageName: educator.profileImageURL, width: 60, height: 60)
                            .scaledToFit()
                            .frame(width: 100, height: 90)
                        
//                        Image("blank")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                    }
                    VStack(alignment: .leading){
                        Text(educator.firstName + " " + educator.lastName)
                            .font(.custom("Poppins-Medium", size: 18))
                        Text(educator.about)
                            .lineLimit(2)
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(.secondary)
                        
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(20)
                .frame(width: 354, height: 100)
            }
            .navigationTitle("Educators")
            //            .navigationBarBackButtonHidden()
        }
        
    }
    
    #Preview {
        EducatorsListCard(educator: Educator(id: "Dummyq", firstName: "rhdgsvdgr", lastName: "hdvsx", about: "hregsdvz", email: "htdfbvsc", password: "grdsc", phoneNumber: "bfdvcsxa", profileImageURL: "ngbdvs"))
    }


