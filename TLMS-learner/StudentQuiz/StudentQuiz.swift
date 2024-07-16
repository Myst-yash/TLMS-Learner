import SwiftUI

struct QuizView: View {
    @State private var remainingTime = QuizData.dummyData.time // Remaining time for the quiz
    @State private var currentQuestionIndex = 0 // Index of the current question being displayed
    @State private var quizSubmitted = false // Tracks if the quiz has been submitted
    
    @State private var questions: [Question] = QuizData.dummyData.questions // State for quiz questions
    @State private var showAlert = false // State to track the presentation of the alert

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
                    .hidden()
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TimerView(remainingTime: $remainingTime, onTimerEnd: submitQuiz)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showAlert = true
                }) {
                    Image(systemName: "xmark")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("End Quiz"),
                message: Text("Are you sure you want to end the quiz? Your progress will be lost."),
                primaryButton: .destructive(Text("End")) {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let window = scene.windows.first {
                            window.rootViewController = UIHostingController(rootView: NodeJsCourseView(courseName: "Node js from Scratch", courseImage: "https://example.com/course-image.jpg"))
                            window.makeKeyAndVisible()
                        }
                    }
                },
                secondaryButton: .cancel(Text("Continue"))
            )
        }
    }
    
    private func submitQuiz() {
        quizSubmitted = true
    }
    
    private func calculateScore() -> Int {
        questions.filter { $0.selectedAnswer == $0.correctAnswer }.count
    }
}

struct TimerView: View {
    @Binding var remainingTime: Int
    let onTimerEnd: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "clock")
            Text("\(remainingTime / 60) mins \(remainingTime % 60) secs remaining")
                .font(.custom("Poppins-Medium", size: 12))
        }
        .onAppear {
            startTimer()
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.invalidate()
                onTimerEnd()
            }
        }
    }
}

// View to display a single quiz question
struct QuestionView: View {
    let question: Question // Question data model
    @Binding var selectedChoice: String // Binding for selected answer
    let numberOfQuestions: Int // Total number of questions
    
    var body: some View {
        VStack(alignment: .leading) {
            // Display question number and text
            Text("QUESTION \(question.id) OF \(numberOfQuestions)")
                .font(.custom("Poppins-Bold", size: 14)) // Custom font
                .foregroundColor(.gray) // Gray color
                .padding(.vertical, 10) // Vertical padding
            
            // Display question text
            Text(question.text)
                .font(.custom("Poppins-Bold", size: 20)) // Custom font
                .fontWeight(.bold) // Bold font weight
                .padding(.bottom, 20) // Bottom padding
            
            // Display choices for the question
            ForEach(question.choices, id: \.self) { choice in
                ChoiceView(choice: choice, selectedChoice: $selectedChoice)
            }
        }
        .padding() // Padding around the content
    }
}

// View to display a choice for a quiz question
struct ChoiceView: View {
    let choice: String // Choice text
    @Binding var selectedChoice: String // Binding for selected answer

    var body: some View {
        Button(action: {
            selectedChoice = choice // Update selected choice when button is tapped
        }) {
            HStack {
                // Display checkmark for selected choice
                Image(systemName: selectedChoice == choice ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(selectedChoice == choice ? Color("color 2") : .primary) // Custom color for selected choice
                    .imageScale(.large) // Larger image scale
                Text(choice)
                    .font(.custom("Poppins-Regular", size: 14)) // Custom font for choice text
                Spacer()
            }
            .padding() // Padding around the content
            .background(selectedChoice == choice ? Color("color 2").opacity(0.1) : Color.clear) // Background color for selected choice
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1) // Border stroke
            )
            .cornerRadius(10) // Corner radius for the button
        }
        .buttonStyle(PlainButtonStyle()) // Plain button style
    }
}

// View to display the bottom navigation bar
struct CustomBottomBar: View {
    let isLastQuestion: Bool // Flag indicating if it's the last question
    let action: () -> Void // Action closure for button tap
    let courseName: String // Course name
    
    var body: some View {
        VStack(spacing: 4) {
            Divider() // Divider line
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    // Display course name
                    Text(courseName)
                        .font(.custom("Poppins-Bold", size: 18)) // Custom font for course name
                        .foregroundColor(.black) // Black color
                        .padding(.leading, 30) // Leading padding
                    
                    // Display assessment text
                    Text("Final Assessment")
                        .font(.custom("Poppins-Medium", size: 14)) // Custom font for assessment text
                        .foregroundColor(.gray) // Gray color
                        .padding(.leading, 30) // Leading padding
                }
                
                Spacer() // Spacer view
                
                // Display navigation button based on whether it's the last question
                NavigationButton(isLastQuestion: isLastQuestion, action: action)
                    .frame(width: 100, height: 50) // Button size
                    .padding(.trailing, 30) // Trailing padding
            }
            .padding(.top) // Top padding
        }
        .background(Color.white) // White background
        .padding(.top, 40) // Top padding
    }
}

// View to display a navigation button
struct NavigationButton: View {
    let isLastQuestion: Bool // Flag indicating if it's the last question
    let action: () -> Void // Action closure for button tap

    var body: some View {
        if !isLastQuestion {
            Button(action: action) {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.right") // Arrow right icon
                        .resizable()
                        .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit) // Aspect ratio for the icon
                        .foregroundColor(Color("color 2")) // Custom color for the icon
                        .frame(width: 40) // Fixed width
                        .background(Color.white) // White background
                }
                .padding(.trailing, 20) // Trailing padding
            }
        } else {
            CustomButton(label: "Submit", action: action) // Display submit button
                .frame(width: 114, height: 50) // Button size
                .cornerRadius(12) // Corner radius for the button
                .shadow(radius: 5) // Shadow effect
        }
    }
}

// Model for a quiz question
struct Question: Identifiable {
    let id: Int // Question ID
    let text: String // Question text
    let choices: [String] // List of choices
    let correctAnswer: String // Correct answer
    var selectedAnswer: String? = nil // Selected answer, initially nil
}

// Model for quiz data
struct QuizData {
    let time: Int // Total time for the quiz in seconds
    let courseName: String // Name of the course
    let questions: [Question] // List of quiz questions
    
    // Dummy data for preview and testing
    static let dummyData = QuizData(
        time: 12, // 20 minutes in seconds
        courseName: "Node js from Scratch", // Course name
        questions: [
            Question(id: 1, text: "What is Node.js?", choices: [
                "A front-end JavaScript framework.",
                "A server-side runtime environment.",
                "A relational database management system.",
                "An HTML preprocessor."
            ], correctAnswer: "A server-side runtime environment."),
            Question(id: 2, text: "Which of the following is NOT a core module in Node.js?", choices: [
                "http",
                "fs",
                "path",
                "ajax"
            ], correctAnswer: "ajax"),
            Question(id: 3, text: "What is npm in the context of Node.js?", choices: [
                "Node Package Manager, used for package management.",
                "Node Preprocessing Module, used for code preprocessing.",
                "Node Project Manager, used for project lifecycle management.",
                "Node Package Middleware, used for HTTP middleware."
            ], correctAnswer: "Node Package Manager, used for package management."),
            Question(id: 4, text: "What is the purpose of package.json in a Node.js project?", choices: [
                "To define the project dependencies and metadata.",
                "To define the HTML structure of the application.",
                "To store JavaScript functions.",
                "To manage SQL databases."
            ], correctAnswer: "To define the project dependencies and metadata."),
            Question(id: 5, text: "How can you include an external module in a Node.js application?", choices: [
                "Using the require() function.",
                "Using the import statement.",
                "By including a <script> tag in HTML.",
                "By defining a class."
            ], correctAnswer: "Using the require() function."),
            Question(id: 6, text: "What is callback hell in Node.js?", choices: [
                "A situation where callbacks are nested deeply.",
                "A feature of Node.js for handling asynchronous code.",
                "A popular Node.js design pattern.",
                "A tool for debugging Node.js applications."
            ], correctAnswer: "A situation where callbacks are nested deeply."),
            Question(id: 7, text: "What is Express.js?", choices: [
                "A templating engine for Node.js.",
                "A JavaScript testing framework.",
                "A minimalist web framework for Node.js.",
                "A database management system."
            ], correctAnswer: "A minimalist web framework for Node.js."),
            Question(id: 8, text: "What does RESTful API mean in the context of Node.js?", choices: [
                "Representational State Transfer, an architectural style for networked applications.",
                "A Node.js package for handling REST requests.",
                "A JavaScript library for UI development.",
                "A security feature in Node.js."
            ], correctAnswer: "Representational State Transfer, an architectural style for networked applications."),
            Question(id: 9, text: "What is middleware in the context of Express.js?", choices: [
                "Software that provides common services and capabilities to applications outside of what's offered by the operating system.",
                "A package manager for Node.js.",
                "A type of Node.js module.",
                "A web server for Node.js."
            ], correctAnswer: "Software that provides common services and capabilities to applications outside of what's offered by the operating system."),
            Question(id: 10, text: "How can you handle errors in Express.js?", choices: [
                "By using try-catch blocks.",
                "By using the errorHandler middleware in Express.",
                "By using console.log() statements.",
                "By using the npm package 'error-handler'."
            ], correctAnswer: "By using the errorHandler middleware in Express.")
        ]
    )
}

// Extension to safely access elements by index from a collection
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView() // Preview for QuizView
    }
}
