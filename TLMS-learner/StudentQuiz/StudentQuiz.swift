import SwiftUI

struct QuizView: View {
    @State private var remainingTime = QuizData.dummyData.time // in seconds, e.g., 20 minutes
    @State private var currentQuestionIndex = 0
    @State private var selectedChoice: String = ""
    
    @State private var questions: [Question] = QuizData.dummyData.questions
    @State private var numberOfQuestions: Int = QuizData.dummyData.questions.count
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ProgressView(value: Double(currentQuestionIndex + 1), total: Double(numberOfQuestions))
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("color 2")))
                    .frame(height: 4)
                
                if !questions.isEmpty {
                    QuestionView(
                        question: questions[currentQuestionIndex],
                        selectedChoice: $selectedChoice,
                        numberOfQuestions: numberOfQuestions
                    )
                }
                
                Spacer()
                
                CustomBottomBar(
                    isLastQuestion: currentQuestionIndex == numberOfQuestions - 1,
                    action: {
                        if currentQuestionIndex < numberOfQuestions - 1 {
                            currentQuestionIndex += 1
                            selectedChoice = ""
                        } else {
                            // Handle submission
                        }
                    },
                    courseName: QuizData.dummyData.courseName
                )
                .frame(height: 100)
                .padding(.bottom, 0) // Adjust bottom padding if needed
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TimerView(remainingTime: $remainingTime)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Handle back action
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct TimerView: View {
    @Binding var remainingTime: Int

    var body: some View {
        HStack {
            Image(systemName: "clock")
            Text("\(remainingTime / 60) mins \(remainingTime % 60) secs remaining")
                .font(.custom("Poppins-Medium", size: 12)) // Adjust font size if needed
        }
        .onAppear {
            startTimer()
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct QuestionView: View {
    let question: Question
    @Binding var selectedChoice: String
    let numberOfQuestions: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("QUESTION \(question.id) OF \(numberOfQuestions)")
                .font(.custom("Poppins-SemiBold", size: 14))
                .foregroundColor(.gray)
            Text(question.text)
                .font(.custom("Poppins-Bold", size: 20))
                .fontWeight(.bold)
                .padding(.vertical)
            
            ForEach(question.choices, id: \.self) { choice in
                ChoiceView(choice: choice, selectedChoice: self.$selectedChoice)
            }
        }
        .padding()
    }
}

struct ChoiceView: View {
    let choice: String
    @Binding var selectedChoice: String

    var body: some View {
        Button(action: {
            self.selectedChoice = self.choice
        }) {
            HStack {
                Image(systemName: self.selectedChoice == self.choice ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(self.selectedChoice == self.choice ? Color("color 2") : .primary)
                    .imageScale(.large)
                Text(self.choice)
                    .font(.custom("Poppins-Regular", size: 16)) // Adjust font size if needed
                Spacer()
            }
            .padding()
            .background(self.selectedChoice == self.choice ? Color("color 2").opacity(0.1) : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomBottomBar: View {
    let isLastQuestion: Bool
    let action: () -> Void
    let courseName: String
    
    var body: some View {
        VStack(spacing: 4) {
            Divider()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(courseName)
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(.black)
                    
                    Text("Final Assessment")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(.gray)
                }
                Spacer()
                NavigationButton(isLastQuestion: isLastQuestion, action: action)
                    .frame(width: 100, height: 50)
                    .padding(.horizontal, 20)
            }
            .padding()
        }
        .background(Color.white)
        .padding(.top, 40)
    }
}

struct NavigationButton: View {
    let isLastQuestion: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if !isLastQuestion {
                Image(systemName: "arrow.right")
                    .foregroundColor(Color("color 2"))
                    .frame(width: 50, height: 50)
                    .background(Color.white)
            } else {
                Text("Submit")
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .frame(width: 114, height: 50)
                    .background(Color("color 2"))
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
        }
    }
}

struct Question: Identifiable {
    let id: Int
    let text: String
    let choices: [String]
    let correctAnswer: String
}

struct QuizData {
    let time: Int
    let courseName: String
    let questions: [Question]
    
    static let dummyData = QuizData(
        time: 1200,
        courseName: "Swift Fundamentals",
        questions: [
            Question(id: 1, text: "What is the primary purpose of the require function in Node.js?", choices: [
                "To define a new function in Node.js.",
                "To read a file from the file system.",
                "To import and use modules in a Node.js application.",
                "To execute a system command from within a Node.js script."
            ], correctAnswer: "To import and use modules in a Node.js application."),
            Question(id: 2, text: "Which of the following is NOT a JavaScript data type?", choices: [
                "Number",
                "String",
                "Boolean",
                "Float"
            ], correctAnswer: "Float"),
            Question(id: 3, text: "What does CSS stand for?", choices: [
                "Creative Style Sheets",
                "Cascading Style Sheets",
                "Computer Style Sheets",
                "Colorful Style Sheets"
            ], correctAnswer: "Cascading Style Sheets"),
            Question(id: 4, text: "Inside which HTML element do we put the JavaScript?", choices: [
                "<js>",
                "<javascript>",
                "<script>",
                "<scripting>"
            ], correctAnswer: "<script>"),
            Question(id: 5, text: "Which HTML attribute is used to define inline styles?", choices: [
                "style",
                "styles",
                "class",
                "font"
            ], correctAnswer: "style")
        ]
    )
}

#Preview {
    QuizView()
}
