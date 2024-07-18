import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        DatabaseManager.shared.fetchMessages { [weak self] result in
            switch result {
            case .success(let msgs):
                DispatchQueue.main.async {
                    self?.messages = msgs
                }
            case .failure(let error):
                print(error)
            }
        }
        subscribeToMessagePublisher()
    }
    
    func sendMessage(text: String, completion: @escaping (Bool) -> Void) {
        guard let user = AuthManager.shared.getCurrentUser() else {
            completion(false)
            return
        }
        
        let newMessage = Message(id: UUID(), useruid: user.uid, text: text, photoURL: user.photoUrl, createdAt: Date())
        
        // Immediately append the new message locally
        DispatchQueue.main.async {
            self.messages.append(newMessage)
        }
        
        DatabaseManager.shared.sendMessageToDatabase(message: newMessage) { success in
            if !success {
                // Handle failure if necessary (e.g., remove message from local array)
                DispatchQueue.main.async {
                    if let index = self.messages.firstIndex(where: { $0.id == newMessage.id }) {
                        self.messages.remove(at: index)
                    }
                }
            }
            completion(success)
        }
    }

    private func subscribeToMessagePublisher() {
        DatabaseManager.shared.messagePublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] messages in
                DispatchQueue.main.async {
                    self?.messages = messages
                }
            }
            .store(in: &subscribers)
    }
}
