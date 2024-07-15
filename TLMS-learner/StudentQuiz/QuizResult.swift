//
//  QuizResult.swift
//  TLMS-learner
//
//  Created by Myst on 14/07/24.
//

import SwiftUI

// Assuming you have QuestionDetailView defined somewhere like this
struct QuestionDetailView: View {
    let question: Question

    var body: some View {
        VStack(alignment: .leading) {
            Text("Question \(question.id)")
                .font(.custom("Poppins-Bold", size: 20))
                .padding(.bottom, 10)
            Text(question.text)
                .font(.custom("Poppins-Regular", size: 16))
                .padding(.bottom, 20)

            ForEach(question.choices, id: \.self) { choice in
                HStack {
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
        if obtainedPercentage >= 67 {
            return Color(red: 0.56, green: 0.81, blue: 0.37) // Green
        } else {
            return Color(red: 0.81, green: 0.37, blue: 0.37) // Red
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(circleColor)
                                .frame(width: 100, height: 100)
                            Text("\(obtainedPercentage)")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(.white)
                        }
                        .padding()
                        VStack(alignment: .leading) {
                            Text(courseName)
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(.white)
                            Text("Final Exam")
                                .font(.custom("Poppins-Medium", size: 16))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.leading) // Add padding to move content to the left
                    }
                    .cornerRadius(20)
                    
                    Rectangle()
                        .fill(Color.white)
                        .opacity(0.85)
                        .frame(height: 100)
                        .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 4)
                        .overlay(
                            HStack(spacing: 0) {
                                VStack(spacing: 10) {
                                    Text("Passing Grade")
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.black)
                                    Text(passingGrade)
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                
                                VStack(spacing: 10) {
                                    Text("Correct")
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.black)
                                    Text(correctAnswers)
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                
                                VStack(spacing: 10) {
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
                
                Divider() // Add a divider between top and bottom sections
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
                                        Text("Question \(question.id)")
                                            .font(.custom("Poppins-Bold", size: 14))
                                            .foregroundColor(.black)
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
                    .padding(.bottom, 20) // Add padding to bottom to prevent content from sticking to the edge
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    // Handle share action if needed
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func isAnswerCorrect(for question: Question) -> Bool {
        guard let selectedAnswer = question.selectedAnswer else {
            return false
        }
        return selectedAnswer == question.correctAnswer
    }
    
    private func calculateCorrectAnswers() -> Int {
        questions.filter { $0.selectedAnswer == $0.correctAnswer }.count
    }
    
    private func calculateWrongAnswers() -> Int {
        questions.count - calculateCorrectAnswers()
    }
}

// Preview for ResultView
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let questions = QuizData.dummyData.questions
        let totalQuestions = questions.count
        let passingPercentage = 67 // 2/3 of total
        let passingScore = (passingPercentage * totalQuestions) / 100
        let passingGrade = "\(passingScore)/\(totalQuestions)"
        let correctAnswers = "\(31)/\(totalQuestions)" // Assuming 31 correct out of 40 for preview
        let wrongAnswers = "\(9)/\(totalQuestions)" // Assuming 9 wrong out of 40 for preview
        
        return ResultView(
            score: 88,
            courseName: "SwiftUI Course",
            questions: questions
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Result View Preview")
    }
}
