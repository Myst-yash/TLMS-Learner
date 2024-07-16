import SwiftUI

struct QuestionDetailView: View {
    let question: Question

    var body: some View {
        VStack(alignment: .leading) {
            // Display the question number
            Text("Question \(question.id)")
                .font(.custom("Poppins-Bold", size: 20))
                .padding(.bottom, 10)
            // Display the question text
            Text(question.text)
                .font(.custom("Poppins-Regular", size: 16))
                .padding(.bottom, 20)

            // Display answer choices with selection indication
            ForEach(question.choices, id: \.self) { choice in
                HStack {
                    // Display a checkmark for selected answer, circle otherwise
                    Image(systemName: question.selectedAnswer == choice ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(question.selectedAnswer == choice ? .green : .primary)
                    Text(choice)
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            Spacer()
        }
        .padding()
    }
}

struct ResultView: View {
    let score: Int
    let courseName: String
    let questions: [Question]
    
    // State to track the presentation of the alert
    @State private var showAlert = false
    
    var passingGrade: String {
        let totalQuestions = questions.count
        let passingPercentage = 67 // 2/3 of total
        let passingScore = (passingPercentage * totalQuestions) / 100
        return "\(passingScore)/\(totalQuestions)"
    }
    
    var correctAnswers: String {
        "\(calculateCorrectAnswers())/\(questions.count)"
    }
    
    var wrongAnswers: String {
        "\(calculateWrongAnswers())/\(questions.count)"
    }
    
    var obtainedPercentage: Int {
        let correctCount = calculateCorrectAnswers()
        let totalQuestions = questions.count
        let percentage = (Double(correctCount) / Double(totalQuestions)) * 100
        return Int(percentage.rounded())
    }
    
    var circleColor: Color {
        // Determine circle color based on passing percentage
        if obtainedPercentage >= 67 {
            return Color(red: 0.56, green: 0.81, blue: 0.37) // Green
        } else {
            return Color(red: 0.81, green: 0.37, blue: 0.37) // Red
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top section with score, course name, and exam type
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            // Circular progress indicator based on obtained percentage
                            Circle()
                                .fill(circleColor)
                                .frame(width: 100, height: 100)
                            Text("\(obtainedPercentage)")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 10)
                        .padding()
                        VStack(alignment: .leading) {
                            // Display course name and exam type
                            Text(courseName)
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(.white)
                            Text("Final Exam")
                                .font(.custom("Poppins-Medium", size: 16))
                                .foregroundColor(Color(red: 0.71, green: 0.69, blue: 0.69))
                        }
                    }
                    .cornerRadius(20)
                    
                    // Summary stats (passing grade, correct answers, wrong answers)
                    Rectangle()
                        .fill(Color.white)
                        .opacity(0.85)
                        .frame(height: 100)
                        .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 4)
                        .overlay(
                            HStack(spacing: 0) {
                                VStack(spacing: 12) {
                                    // Display passing grade
                                    Text("Passing Grade")
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.black)
                                    Text(passingGrade)
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Rectangle()
                                    .fill(Color(red: 0.4, green: 0.4, blue: 0.4).opacity(0.3))
                                    .frame(width: 1, height: 50)
                                    .frame(alignment: .center)
                                
                                VStack(spacing: 12) {
                                    // Display correct answers count
                                    Text("Correct")
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.black)
                                    Text(correctAnswers)
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Rectangle()
                                    .fill(Color(red: 0.4, green: 0.4, blue: 0.4).opacity(0.3))
                                    .frame(width: 1, height: 40)
                                    .frame(alignment: .center)
                                
                                VStack(spacing: 12) {
                                    // Display wrong answers count
                                    Text("Wrong")
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.black)
                                    Text(wrongAnswers)
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding()
                        )
                }
                .frame(height: 237) // Set the height of the top background to 250
                .background(Color("color 2"))
                
                // Divider between top and question list
                Divider()
                
                // Scrollable list of questions and their correctness status
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("List of Questions")
                            .font(.custom("Poppins-Regular", size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            .padding(.top, 20)
                            .padding(.horizontal)

                        ForEach(questions) { question in
                            NavigationLink(destination: QuestionDetailView(question: question)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        // Display question number
                                        Text("Question \(question.id)")
                                            .font(.custom("Poppins-Bold", size: 14))
                                            .foregroundColor(.black)
                                        // Display correctness status
                                        Text(isAnswerCorrect(for: question) ? "Correct Answer" : "Wrong Answer")
                                            .font(.custom("Poppins-Regular", size: 14))
                                            .foregroundColor(isAnswerCorrect(for: question) ? Color(red: 0.56, green: 0.81, blue: 0.37) : Color(red: 0.81, green: 0.37, blue: 0.37))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 20)
                                .background(Color.white) // Transparent background
                            }
                            Rectangle()
                                .fill(Color(red: 0.4, green: 0.4, blue: 0.4).opacity(0.3))
                                .frame(width: 350, height: 1)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding(.bottom, 10) // Add padding to bottom to prevent content from sticking to the edge
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem {
                Button(action: {
                    // Handle share action if needed
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showAlert = true
                }) {
                    Image(systemName: "xmark") // Display close icon
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Leave Page"),
                message: Text("Are you sure you really want to leave?"),
                primaryButton: .destructive(Text("Leave")) {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let window = scene.windows.first {
                            window.rootViewController = UIHostingController(rootView: NodeJsCourseView(courseName: "Node js from Scratch", courseImage: "https://example.com/course-image.jpg"))
                            window.makeKeyAndVisible()
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    // Determine if the selected answer matches the correct answer
    private func isAnswerCorrect(for question: Question) -> Bool {
        guard let selectedAnswer = question.selectedAnswer else {
            return false
        }
        return selectedAnswer == question.correctAnswer
    }
    
    // Calculate the number of correctly answered questions
    private func calculateCorrectAnswers() -> Int {
        questions.filter { $0.selectedAnswer == $0.correctAnswer }.count
    }
    
    // Calculate the number of incorrectly answered questions
    private func calculateWrongAnswers() -> Int {
        questions.count - calculateCorrectAnswers()
    }
}

// Preview for ResultView
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let questions = QuizData.dummyData.questions
        return ResultView(
            score: 88,
            courseName: "Node js from Scratch",
            questions: questions
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Result View Preview")
    }
}
