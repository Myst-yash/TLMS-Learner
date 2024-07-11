import Foundation
import SwiftUI



struct EducatorView: View {
    @State var educators:[Educators] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List(educators) { educator in
                    HStack(spacing: 30) {
                        ZStack {
                            
                            
                            Image("blob")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                                    
                            
                            ProfileImage(imageURL: educator.imageUrl)
//                            Image("educator").resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 75).padding(.top, 10).padding(.leading, 10)
                            Image("blank").resizable().frame(width: 106, height: 100)
                            
                        }.padding(.leading, -10)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(educator.firstName) \(educator.lastName)")
                                .font(.title2).bold()
                            Text(educator.about)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
                
                Spacer()
                
                
            }
            .navigationBarTitle("My Educators", displayMode: .large)
            .onAppear(perform: {
                FirebaseServices.shared.fetchEducators { fetchedData in
                    self.educators = fetchedData
                }
            })
        }
    }
}


struct UpcomingCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        EducatorView()
    }
}


struct ProfileImage: View {
    var imageURL: String?
    var width : CGFloat?
    var height : CGFloat?

    var body: some View {
        if let urlString = imageURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 75).padding(.top, 10).padding(.leading, 10)
            }
            placeholder: {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
                .clipShape(Circle())
                .padding(.vertical, 8)
        }
    }
}
