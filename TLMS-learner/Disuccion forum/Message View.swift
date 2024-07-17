//
//  Message View.swift
//  TLMS-learner
//
//  Created by Mac on 17/07/24.
//


import SwiftUI
import SDWebImageSwiftUI

struct MessageView: View {
    var message: Message
    
    var body: some View {
        if message.isFromCurrentUser() {
            HStack {
                HStack{
                    Text(message.text)
                        .padding()
                        .background(.mint)
                        .cornerRadius(20)
                    
                }
                .frame(maxWidth: 260,alignment: .trailing)
                if let photoURL =  message.fetchPhotoURL() {
                                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth:32,maxHeight:32,alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom,24)
                        .padding(.leading,4)
                    
                    
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth:32,maxHeight:32,alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom,24)
                        .padding(.leading,4)
                        .foregroundColor(.gray)
                }
               
                
            }
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.trailing)
            
        }else{
            HStack {
                if let photoURL =  message.fetchPhotoURL() {
                                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth:32,maxHeight:32,alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom,24)
                        .padding(.leading,4)
                    
                    
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth:32,maxHeight:32,alignment: .top)
                        .cornerRadius(16)
                        .padding(.bottom,24)
                        .padding(.leading,4)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text(message.text)
                        .padding()
                        .background(Color(uiColor: .systemGray5))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 260,alignment: .leading)
               
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading)
        }
        
    }

}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message:Message(id: UUID(), useruid: "123", text: "Hello i am ishika,how are you what ur name Hello i am ishika how are you what ur name?", photoURL: "", createdAt: Date()))
//     Chatview()
        
    }
}
