import SwiftUI

struct QuizView: View {
    @State private var remainingTime = QuizData.dummyData.time
    @State private var currentQuestionIndex = 0
    @State private var quizSubmitted = false // Track if quiz is submitted

    @State private var questions: [Question] = QuizData.dummyData.questions // Updated to @State

    private var numberOfQuestions: Int {
        questions.count
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ProgressView(value: Double(currentQuestionIndex), total: Double(numberOfQuestions))
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("color 2")))
                    .frame(height: 4)
                
                if let currentQuestion = questions[safe: currentQuestionIndex] {
                    QuestionView(
                        question: currentQuestion,
                        selectedChoice: Binding(
                            get: { currentQuestion.selectedAnswer ?? "" },
                            set: { questions[currentQuestionIndex].selectedAnswer = $0 }
                        ),
                        numberOfQuestions: numberOfQuestions
                    )
                }
                
                Spacer()
                
                CustomBottomBar(
                    isLastQuestion: currentQuestionIndex == numberOfQuestions - 1,
                    action: {
                        if currentQuestionIndex < numberOfQuestions - 1 {
                            currentQuestionIndex += 1
                        } else {
                            submitQuiz()
                        }
                    },
                    courseName: QuizData.dummyData.courseName
                )
                .frame(height: 100)
                .padding(.bottom, 0)
                .background(
                    NavigationLink(destination: ResultView(
                        score: calculateScore(),
                        courseName: QuizData.dummyData.courseName,
                        questions: questions
                    ), isActive: $quizSubmitted) {
                        EmptyView()
                    }
                    .hidden() // Hide the NavigationLink label
                )
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
    
    private func submitQuiz() {
        quizSubmitted = true
    }
    
    private func calculateScore() -> Int {
        questions.filter { $0.selectedAnswer == $0.correctAnswer }.count
    }
}

// TimerView struct remains unchanged
struct TimerView: View {
    @Binding var remainingTime: Int

    var body: some View {
        HStack {
            Image(systemName: "clock")
            Text("\(remainingTime / 60) mins \(remainingTime % 60) secs remaining")
                .font(.custom("Poppins-Medium", size: 12))
        }
        .onAppear {
            // Start the timer when the view appears
            startTimer()
        }
    }

    private func startTimer() {
        // Timer to decrement remaining time every second
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                // Invalidate timer when time is up
                timer.invalidate()
            }
        }
    }
}

// QuestionView struct remains unchanged
struct QuestionView: View {
    let question: Question
    @Binding var selectedChoice: String
    let numberOfQuestions: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            // Display question number and text
            Text("QUESTION \(question.id) OF \(numberOfQuestions)")
                .font(.custom("Poppins-Bold", size: 14))
                .foregroundColor(.gray)
                .padding(.vertical, 10)
            Text(question.text)
                .font(.custom("Poppins-Bold", size: 20))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            // Display choices for the question
            ForEach(question.choices, id: \.self) { choice in
                ChoiceView(choice: choice, selectedChoice: $selectedChoice)
            }
        }
        .padding()
    }
}

// ChoiceView struct remains unchanged
struct ChoiceView: View {
    let choice: String
    @Binding var selectedChoice: String

    var body: some View {
        Button(action: {
            // Update selected choice when button is tapped
            selectedChoice = choice
        }) {
            HStack {
                // Display checkmark for selected choice
                Image(systemName: selectedChoice == choice ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(selectedChoice == choice ? Color("color 2") : .primary)
                    .imageScale(.large)
                Text(choice)
                    .font(.custom("Poppins-Regular", size: 14))
                Spacer()
            }
            .padding()
            .background(selectedChoice == choice ? Color("color 2").opacity(0.1) : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// CustomBottomBar struct remains unchanged
struct CustomBottomBar: View {
    let isLastQuestion: Bool
    let action: () -> Void
    let courseName: String
    
    var body: some View {
        VStack(spacing: 4) {
            Divider()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    // Display course name and assessment text
                    Text(courseName)
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(.black)
                        .padding(.leading, 30)
                    
                    Text("Final Assessment")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(.gray)
                        .padding(.leading, 30)
                }
                Spacer()
                // Display navigation button based on whether it's the last question
                NavigationButton(isLastQuestion: isLastQuestion, action: action)
                    .frame(width: 100, height: 50)
                    .padding(.trailing, 30)
            }
            .padding(.top)
        }
        .background(Color.white)
        .padding(.top, 40)
    }
}

// NavigationButton struct remains unchanged
struct NavigationButton: View {
    let isLastQuestion: Bool
    let action: () -> Void

    var body: some View {
        if !isLastQuestion {
            Button(action: action) {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit)
                        .foregroundColor(Color("color 2"))
                        .frame(width: 40)
                        .background(Color.white)
                }
                .padding(.trailing, 20)
            }
        } else {
            CustomButton(label: "Submit", action: action)
                .frame(width: 114, height: 50)
                .cornerRadius(12)
                .shadow(radius: 5)
        }
    }
}

// Question struct remains unchanged
struct Question: Identifiable {
    let id: Int
    let text: String
    let choices: [String]
    let correctAnswer: String
    var selectedAnswer: String? = nil
}

// QuizData struct remains unchanged
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
            ], correctAnswer: "style"),
            
                Question(id: 6, text: "What is the primary purpose of the require function in Node.js?", choices: [
                    "To define a new function in Node.js.",
                    "To read a file from the file system.",
                    "To import and use modules in a Node.js application.",
                    "To execute a system command from within a Node.js script."
                ], correctAnswer: "To import and use modules in a Node.js application."),
                Question(id: 7, text: "Which of the following is NOT a JavaScript data type?", choices: [
                    "Number",
                    "String",
                    "Boolean",
                    "Float"
                ], correctAnswer: "Float"),
                Question(id: 8, text: "What does CSS stand for?", choices: [
                    "Creative Style Sheets",
                    "Cascading Style Sheets",
                    "Computer Style Sheets",
                    "Colorful Style Sheets"
                ], correctAnswer: "Cascading Style Sheets"),
                Question(id: 9, text: "Inside which HTML element do we put the JavaScript?", choices: [
                    "<js>",
                    "<javascript>",
                    "<script>",
                    "<scripting>"
                ], correctAnswer: "<script>"),
                Question(id: 10, text: "Which HTML attribute is used to define inline styles?", choices: [
                    "style",
                    "styles",
                    "class",
                    "font"
                ], correctAnswer: "style")

        ]
    )
}

// Safe subscript extension remains unchanged
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Preview for QuizView
struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
