//
//  EducatorsProfile.swift
//  TLMS-learner
//
//  Created by Abid Ali    on 12/07/24.
//



import SwiftUI

struct EducatorProfileView: View {
    var id : String
    var firstName:String
    var lastName:String
    var image :String
    var about:String
    var body: some View {
        VStack {
            ScrollView{
                VStack {
//                    Image("meow")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 120, height: 120)
//                        .clipShape(Circle())
//                        .padding(.bottom, 10)
                    
                    
                    AsyncImage(url: URL(string: image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text("\(firstName) \(lastName)")
                        .font(.system(size: 28, weight: .bold))

                    HStack {
                        Image(systemName: "graduationcap")
                        Text(about)
                            .font(.system(size: 16))
                    }
                    .padding(.top, 4)
                }
                .padding(.bottom, 20)

                ZStack{
                    Image("cart").shadow(color: .gray, radius: 2, x: 0, y: 3)
                    HStack(spacing: 80){
                        VStack{
                            Text("Courses").font(.title2).bold().padding(.top, -10)
                            Text("24").font(.title2).bold().foregroundStyle(.gray)
                            
                            
                        }
                        VStack{
                            Text("Students").font(.title2).bold().padding(.top, -10)
                           
                            Text("120").font(.title2).bold().foregroundStyle(.gray)
                        }
                    }
                    
                }
            }
            
            
            Spacer()
        }
    }
}

//struct CourseView: View {
//    var courseName: String
//    var author: String
//
//    var body: some View {
//        HStack {
//            Image("meow")
//                .resizable()
//                .frame(width: 100, height: 80)
//                .cornerRadius(10)
//
//            VStack(alignment: .leading) {
//                Text(courseName)
//                    .font(.system(size: 18, weight: .semibold))
//                Text("by \(author)")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//            }
//            .padding(.leading, 10)
//
//            Spacer()
//        }
//
//        .padding()
//        .background(Color(UIColor.systemGray6))
//
//        .cornerRadius(10)
//        .shadow(color: .gray, radius: 2, x: 0, y: 3)
//        .padding(.horizontal, 10)
//        .padding(.top, 5)
//    }
//}

struct EducatorCourseCard: View {
    var body: some View {
        Button(action: {}){
            HStack {
                ZStack{
                    Image("meow").resizable().frame(width: 149, height: 86).cornerRadius(10).padding(.leading, 10)
                    Image(systemName: "play.fill").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(.white)
                }
                
                VStack(alignment: .leading) {
                    Text("Django se Panga")
                        .font(.headline).foregroundStyle(Color.black)
                    Text("by Batman")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                   
                }.padding(.leading, 10)
                Spacer()
            }.frame(width: 359, height: 100).background(Color("color 6"))
                .cornerRadius(10).shadow(color: .gray, radius: 2, x: 0, y: 3)
            
                
                
        }
    }
}
// to display the data pick an id of an educator from firebase and do the same

struct EducatorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EducatorProfileView(id:"",firstName: "",lastName: "",image: "",about: "")
    }
}


