//
//  educator.swift
//  profile
//
//  Created by Abid Ali    on 11/07/24.
//

import Foundation
import SwiftUI

struct Educator: Identifiable {
    let id = UUID()
    let name: String
    let course: String
    let institution: String
}

struct EducatorView: View {
    let educators = [
        Educator(name: "Homelander", course: "MongoDB", institution: "IIIT Hyderabad"),
        Educator(name: "Homelander", course: "MongoDB", institution: "IIIT Hyderabad"),
        Educator(name: "Homelander", course: "MongoDB", institution: "IIIT Hyderabad"),
        Educator(name: "Homelander", course: "MongoDB", institution: "IIIT Hyderabad"),
        Educator(name: "Homelander", course: "MongoDB", institution: "IIIT Hyderabad")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List(educators) { educator in
                    HStack(spacing: 30) {
                        ZStack {
                            
                            
                            Image("blob") // Replace with your image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                            
                            // educator Image //
                            Image("educator").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 80, height: 75).padding(.top, 10).padding(.leading, 10)
                            Image("blank").resizable().frame(width: 106, height: 100)
                            
                        }.padding(.leading, -10)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(educator.name)
                                .font(.title2).bold()
                            Text(educator.course)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(educator.institution)
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
            .navigationBarItems(leading: Button(action: {
                // Add back button action here
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundColor(.blue)
            })
        }
    }
}


struct UpcomingCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        EducatorView()
    }
}


