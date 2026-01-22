//
//  QwizProgressManager.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2026-01-20.
//

import Foundation
import Combine

class QuizProgressManager: ObservableObject {
    @Published var juniorCompleted: Bool {
        didSet { UserDefaults.standard.set(juniorCompleted, forKey: "juniorCompleted") }
    }
    @Published var midCompleted: Bool {
        didSet { UserDefaults.standard.set(midCompleted, forKey: "midCompleted") }
    }
    @Published var juniorScore: Int {
        didSet { UserDefaults.standard.set(juniorScore, forKey: "juniorScore") }
    }
    @Published var midScore: Int {
        didSet { UserDefaults.standard.set(midScore, forKey: "midScore") }
    }
    @Published var seniorScore: Int {
        didSet { UserDefaults.standard.set(seniorScore, forKey: "seniorScore") }
    }
    
    init() {
        self.juniorCompleted = UserDefaults.standard.bool(forKey: "juniorCompleted")
        self.midCompleted = UserDefaults.standard.bool(forKey: "midCompleted")
        self.juniorScore = UserDefaults.standard.integer(forKey: "juniorScore")
        self.midScore = UserDefaults.standard.integer(forKey: "midScore")
        self.seniorScore = UserDefaults.standard.integer(forKey: "seniorScore")
    }
    
    func isLevelUnlocked(_ level: QuizLevel) -> Bool {
        switch level {
        case .iosJunior:
            return true
        case .iosMid:
            return juniorCompleted
        case .iosSenior:
            return midCompleted
        }
    }
    
    func getScore(for level: QuizLevel) -> Int {
        switch level {
        case .iosJunior: return juniorScore
        case .iosMid: return midScore
        case .iosSenior: return seniorScore
        }
    }
    
    func updateScore(_ score: Int, for level: QuizLevel) {
        switch level {
        case .iosJunior:
            juniorScore = score
        case .iosMid:
            midScore = score
        case .iosSenior:
            seniorScore = score
        }
    }
    
    func completeLevel(_ level: QuizLevel) {
        switch level {
        case .iosJunior:
            juniorCompleted = true
        case .iosMid:
            midCompleted = true
        case .iosSenior:
            break 
        }
    }
}
