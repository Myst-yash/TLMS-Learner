//
//  SwiftUIView.swift
//  TLMS-learner
//
//  Created by Mac on 17/07/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    var subscribers:Set<AnyCancellable> = []
    
    @Published var mockData = [
        Message(id: UUID(), useruid: "123456", text: "hi i am ishika", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "123", text: "hi hello ", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "890", text: "ishika is good girl", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "678", text: "ISHIKA IS MY INTELLIGENT GIRL", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "456", text: "ishika is nice girl", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "123456", text: "hi i am ishika", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "123", text: "hi hello ", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "890", text: "ishika is good girl", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "678", text: "ISHIKA IS MY INTELLIGENT GIRL", photoURL: "", createdAt: Date()),
        Message(id: UUID(), useruid: "456", text: "ishika is nice girl", photoURL: "", createdAt: Date())
    ]
    
    init() {
        DatabaseManager.shared.fetchMessages { [weak self] result in
            switch result {
            case .success(let msgs):
                self?.messages = msgs
            case .failure(let error):
                print(error)
            }
        }
        subscribeToMessagePublisher()
    }
    
    func sendMessage(text: String, completion: @escaping (Bool) -> Void) {
        guard let user = AuthManager.shared.getCurrentUser() else {
            return
        }
        let msg = Message(id: UUID(), useruid: user.uid, text: text, photoURL: user.photoUrl, createdAt: Date())
        DatabaseManager.shared.sendMessgaeToDatabase(message: msg) { [weak self] success in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func refresh() {
        self.messages =  messages
    }
    private func subscribeToMessagePublisher() {
        DatabaseManager.shared.messagePublisher.receive(on: DispatchQueue.main)
            .sink {completion in
                print (completion)
            } receiveValue: { [weak self]messages in
                self?.messages = messages
            }
            .store(in:&subscribers)
    }
}
