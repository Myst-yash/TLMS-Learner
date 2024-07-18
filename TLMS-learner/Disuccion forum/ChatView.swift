import SwiftUI

struct Chatview: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text = ""
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(Array(chatViewModel.messages.enumerated()), id: \.element.id) { idx, message in
                            MessageView(message: message)
                                .id(idx)
                        }
                    }
                }
                .onChange(of: chatViewModel.messages) { _ in
                    DispatchQueue.main.async {
                        if !chatViewModel.messages.isEmpty {
                            scrollView.scrollTo(chatViewModel.messages.count - 1, anchor: .bottom)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Write Something", text: $text, axis: .vertical)
                    .padding()
                ZStack {
                    Button {
                        if text.count > 2 {
                            chatViewModel.sendMessage(text: text) { success in
                                if success {
                                    text = ""
                                } else {
                                    print("error sending messages")
                                }
                            }
                        }
                    } label: {
                                               Image(systemName: "arrow.up.circle.fill")
                                                  .resizable()
                                                  .scaledToFit()
                                                  .frame(width: 40, height: 40)
                                                  .foregroundColor(Color("color 2"))
                                                  .padding(.trailing)
                    }
                }
                .padding(.top)
                .shadow(radius: 3)
            }
            .background(Color(uiColor: .systemGray6))
        }
    }
}

#Preview {
    Chatview()
}
