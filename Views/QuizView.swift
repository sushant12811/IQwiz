
//
//  QuizView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-21.
//

import SwiftUI

struct QuizView: View {
    let level: QuizLevel
    @EnvironmentObject var progressManager: QuizProgressManager
    @Environment(\.dismiss) var dismiss
    @Environment(AudioPlayerManager.self) var audioManager: AudioPlayerManager
    @State private var questions: [Quiz] = []
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showFinish = false
    @State private var loadError: String? = nil
    @State private var quitAlertIsPresented: Bool = false
    @State private var showHint: Bool = false
    @State private var userAnswers: [Int?] = []
    @State private var showReview = false
    @State private var savedQuestions: [Quiz] = []
    @State private var savedUserAnswers: [Int?] = []
    @AppStorage("showPulseForOptions") private var showPulse: Bool = true


    var currentQuestion: Quiz? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    var body: some View {
        ZStack(alignment: .bottom) {

            if showReview {
                ReviewAnswersView(
                    questions: questions,
                    userAnswers: userAnswers,
                    onClose: {
                        
                        dismiss()
                    }
                )
            } else if showFinish {
                FinishView(
                    score: score,
                    totalQuestions: questions.count,
                    level: level,
                    onReturnToMenu: {
                        dismiss()
                    },
                    onReviewAnswers: {
                     showReview = true
                    }
                )
                .environmentObject(progressManager)
            } else {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Button(action: {
                            quitAlertIsPresented = true
                        }) {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title2)
                                Text("Quit")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.red)
                        }

                        Spacer()

                        Text(
                            "Question \(currentQuestionIndex + 1)/\(questions.count)"
                        )
                        .font(.headline)
                        .foregroundColor(.secondary)

                        Spacer()

                        Text("Score: \(score)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)

                    //MARK: PROGRESS BAR
                    ProgressView(
                        value: CGFloat(currentQuestionIndex),
                        total: CGFloat(questions.count)
                    )

                    if let error = loadError {
                        VStack {
                            Spacer()
                            Text("Error loading questions")
                                .font(.headline)
                            Text(error)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                        }
                    } else if let question = currentQuestion {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                // Question
                                Text(question.question)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.blue.opacity(0.1))
                                    )

                                // Options
                                VStack(spacing: 12) {
                                    ForEach(question.options.indices,id: \.self) { index in
                                        OptionButtonView(
                                            text: question.options[index],
                                            index: index,
                                            isSelected: selectedAnswer == index,
                                            isCorrect: index
                                                == question.correctAnswerIndex,
                                            showResult: selectedAnswer != nil
                                        ) {
                                            handleAnswerSelection(index)
                                        }
                                        .pulse(index == question.correctAnswerIndex && showPulse)//Handle pulse effect
                                        .overlay{
                                            if (index == question.correctAnswerIndex && showPulse){
                                                HStack{
                                                    Spacer()
                                                    Image(systemName: "hand.tap.fill")
                                                        .imageScale(.large)
                                                        .foregroundStyle(.primary)
                                                    
                                                }
                                                .padding(.trailing, 50)
                                            }
                                        }
                                        
                                    }

                                }

                                //MARK: HINT INFO BUTTON
                                HStack {
                                    Spacer()
                                    Button {
                                        showHint = true
                                    } label: {
                                        Image(systemName: "info.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundStyle(.customBlue)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .padding()

                                    }
                                }.padding()
                            }
                            .padding()
                        }
                    }

                    Spacer()
                }
            }
        }
        .onAppear {
            loadQuestions()
        }
        .onDisappear{
            if !showReview{
                resetQuiz()
            }
        }
        .alert("Quit?", isPresented: $quitAlertIsPresented) {
            Button("Quit", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Are you sure you want to quit? your progress will be lost.")
        }
        .sheet(isPresented: $showHint) {
            if let quizHint = currentQuestion?.hint {
                Text(quizHint)
                    .font(.title3)
                    .padding()
                    .presentationDetents([.height(80), .medium])
            }
        }

    }

    //MARK: LOAD QUESTION
    func loadQuestions() {
        do {
            questions = try QuizService.shared.loadData(for: level)
            userAnswers = Array(repeating: nil as Int?, count: questions.count)
        } catch {
            loadError = error.localizedDescription
        }
    }

    //MARK: HANDLED ANSWER SELECTION
    func handleAnswerSelection(_ index: Int) {
        guard selectedAnswer == nil else { return }

        selectedAnswer = index
        userAnswers[currentQuestionIndex] = index

        if let correctIndex = currentQuestion?.correctAnswerIndex,
            index == correctIndex
        {
            score += 1
            audioManager.playSound(soundName: "correctAnswer", soundType: "mp3")

        } else {
            audioManager.playSound(soundName: "wrongAnswer", soundType: "mp3")

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            moveToNextQuestion()
        }
    }

    //MARK: Next Question
    func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showPulse = false
        } else {
            // Quiz finished
            progressManager.updateScore(score, for: level)
            progressManager.completeLevel(level)
            showFinish = true
        }
    }
    
    //MARK: RESET
    func resetQuiz() {
        questions = []
                    currentQuestionIndex = 0
                    score = 0
                    selectedAnswer = nil
                    showFinish = false
                    showReview = false
                    userAnswers = []
                    loadError = nil
                
    }

}
