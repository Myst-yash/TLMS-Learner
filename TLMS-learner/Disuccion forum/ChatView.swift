//
//  ChatView.swift
//  TLMS-learner
//
//  Created by Mac on 17/07/24.
//

import SwiftUI


struct Chatview: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text =  ""
    var body: some View {
        VStack{
            ScrollViewReader{scrollView in
                ScrollView(showsIndicators:false){
                    VStack(spacing: 8) {
                        ForEach(Array(chatViewModel.messages.enumerated()),id: \.element) {idx, message in
                            MessageView(message: message)
                                .id(idx)
                        }
                        .onChange(of: chatViewModel.messages) { newValue in
                            scrollView.scrollTo(chatViewModel.messages.count - 1 ,anchor: .bottom)}
                    }
                }
            }
            
            HStack {
                TextField("Write Something", text: $text, axis: .vertical)
                    .padding()
                ZStack{
                    Button {
                        if text.count >  2 {
                            chatViewModel.sendMessage(text: text) {success in
                                if success{
                                    
                                }else{
                                    print("error sending messages")
                                }
                            }
                            text = "" }
                    }label: {
                        
                        Text("Send")
                            .padding()
                            .foregroundColor(.white)
                            .background(.indigo)
                            .cornerRadius(50)
                            .padding(.trailing)
                    }
                }.padding(.top)
                    .shadow(radius: 3)
                }  .background(Color(uiColor: .systemGray6))
            }
        
        
        }
    }

#Preview {
    Chatview()
}
