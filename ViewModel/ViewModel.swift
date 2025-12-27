////
////  ViewModel.swift
////  IQwiz
////
////  Created by Sushant Dhakal on 2025-12-20.
////
//
import Foundation
import SwiftUI

@Observable
class ViewModel {
    var quiz: [Quiz] = []
    var currentIndex = 0
    var selectedAnswerIndex: Int?
    var userAnswers: [Int?] = []
    var score = 0
    var isFinished = false
    
    //hasShownPulse -> save after first onboard condition
    var hasShownPulse: Bool {
        get { UserDefaults.standard.bool(forKey: "hasShownPulse") }
        set { UserDefaults.standard.set(newValue, forKey: "hasShownPulse") }
    }
    
    //case of view Status
    enum ViewFlow{
        case onBaordView, homeView, quizView, finishedView
    }
    
    //default status
    var viewStatus: ViewFlow = .onBaordView
    
    //Fetch Status of data
    enum FetchStatus {
        case notStarted, loading, success, failed(error: Error)
    }
    
    private(set) var fetchResult: FetchStatus = .notStarted
    private(set) var service: QuizService
    private let progressKey = "quizProgress"
    
    var hasActiveQuiz: Bool {
        return !userAnswers.allSatisfy { $0 == nil } && !isFinished
    }
    
    //initialization status and service
    init(service: QuizService = BundleService()) {
        self.service = service
        loadQuizzes()
        if !hasShownPulse {
            viewStatus = .onBaordView
        } else if hasActiveQuiz {
            viewStatus = .quizView
        } else {
            viewStatus = .homeView
        }    }
    
    
    //MARK: -LOAD QUIZ
    func loadQuizzes() {
        fetchResult = .loading
        do {
            quiz = try service.loadData()
            
            if userAnswers.count != quiz.count {
                userAnswers = Array(repeating: nil, count: quiz.count)
            }
            loadProgress()
            fetchResult = .success
        } catch {
            print("Failed to load quizzes:", error)
            fetchResult = .failed(error: error)
        }
    }
    
    //MARK: -Current QUIZ
    var currentQuiz: Quiz? {
        guard currentIndex < quiz.count else { return nil }
        return quiz[currentIndex]
    }
    
    //MARK: -Correct Answer Option
    var correctAnswerOption: Int? {
        currentQuiz?.correctAnswerIndex
    }
    
    //MARK: -AnswerCorrect
    var isAnswerCorrect: Bool {
        guard
            let selected = selectedAnswerIndex,
            let correct = correctAnswerOption
        else { return false }
        return selected == correct
    }
    
    //MARK: -SelectedAnswer
    func selectedAnswer(of option: Int) {
        guard currentIndex < userAnswers.count,
              let correct = correctAnswerOption
        else { return }
        
        let previous = userAnswers[currentIndex]
        
        if previous == nil {
            if option == correct { score += 1 }
        } else {
            if previous == correct && option != correct {
                score -= 1
            } else if previous != correct && option == correct {
                score += 1
            }
        }
        
        userAnswers[currentIndex] = option
        selectedAnswerIndex = option
        saveProgress()
    }
    
    //MARK: - Next question
    func nextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            if self.currentIndex < self.quiz.count - 1 {
                self.currentIndex += 1
                self.selectedAnswerIndex = nil
            } else {
                // rchecks result after user answers all
                if !self.userAnswers.contains(nil) {
                    self.isFinished = true
                    self.viewStatus = .finishedView
                }
            }
            self.saveProgress()
        }
    }
    
    //MARK: RESET QUIZ
    func reset(){
        if let previous = userAnswers[currentIndex],
           previous == correctAnswerOption {
            score -= 1
        }
        selectedAnswerIndex = nil
        userAnswers[currentIndex] = nil
        isFinished = false
        saveProgress()
        
    }
    
    //MARK: BACK QUESTIOn
    func backQuestion() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        selectedAnswerIndex = userAnswers[currentIndex]
        saveProgress()
    }
    
    // MARK: - Persistence
    func saveProgress() {
        let progress = QuizProgress(
            currentIndex: currentIndex,
            answers: userAnswers,
            score: score,
            isFinished: isFinished,
        )
        
        if let data = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(data, forKey: progressKey)
        }
    }
    
    //MARK: - LOAD PROGRESS
    func loadProgress() {
        guard
            let data = UserDefaults.standard.data(forKey: progressKey),
            let progress = try? JSONDecoder().decode(QuizProgress.self, from: data),
            progress.answers.count == quiz.count
        else { return }
        
        currentIndex = progress.currentIndex
        userAnswers = progress.answers
        score = progress.score
        isFinished = progress.isFinished
        selectedAnswerIndex = userAnswers[currentIndex]
        
    }
    
    //MARK: - CLEAR QUIZ
    func clearQuiz() {
        userAnswers = Array(repeating: nil, count: quiz.count)
        currentIndex = 0
        score = 0
        isFinished = false
        selectedAnswerIndex = nil
        UserDefaults.standard.removeObject(forKey: progressKey)
        saveProgress()
    }
    
    //MARK: - QUIT QUIZ
    func quitQuiz(){
        clearQuiz()
        viewStatus = .homeView
    }
    
    //MARK: - Restart QUIZ
    func restartQuiz(){
        clearQuiz()
        viewStatus = .quizView
    }
    
    //MARK: - ANSWEROPTIONS COLOR
    func AnswerOptionsColor(index: Int)-> Color{
        guard selectedAnswerIndex != nil else {
            return Color.optionsBlue
        }
        if index == correctAnswerOption{
            return .green
        }
        if index == selectedAnswerIndex{
            return .red
            
        }
        return .gray.opacity(0.7)
        
    }
    
    //MARK: - ReviewOPtions Color
    func reviewOptionColor(questionIndex: Int, optionIndex: Int) -> Color {
        let userAnswer = userAnswers[questionIndex]
        let correct = quiz[questionIndex].correctAnswerIndex

        if optionIndex == correct {
            return .green
        }

        if optionIndex == userAnswer {
            return .red
        }
        return .gray.opacity(0.7)
    }

}

