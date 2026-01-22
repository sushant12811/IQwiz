//
//  QuizLevelCard.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2026-01-05.
//

import SwiftUI

struct QuizLevelCard: View {
    let level: QuizLevel
    @ObservedObject var progressManager: QuizProgressManager
    @State private var showQuiz = false
    @AppStorage("showPulse") private var showPulse: Bool = true

    
    var isUnlocked: Bool {
        progressManager.isLevelUnlocked(level)
    }
    
    var levelTitle: String {
        switch level {
        case .iosJunior: return "Junior Level"
        case .iosMid: return "Mid Level"
        case .iosSenior: return "Senior Level"
        }
    }
    
    var levelColor: Color {
        switch level {
        case .iosJunior: return .green
        case .iosMid: return .orange
        case .iosSenior: return .red
        }
    }
    
    var levelBackgroundColor: Color {
        switch level {
        case .iosJunior: return .green.opacity(0.1)
        case .iosMid: return .orange.opacity(0.1)
        case .iosSenior: return .red.opacity(0.1)
        }
    }
    
    var body: some View {
        Button(action: {
            if isUnlocked {
                showQuiz = true
                showPulse = false
            }
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: isUnlocked ? "checkmark.circle.fill" : "lock.fill")
                            .foregroundColor(isUnlocked ? levelColor : .gray)
                        
                        Text(levelTitle)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(isUnlocked ? .primary : .gray)
                    }
                    
                    if isUnlocked {
                        Text("Best Score: \(progressManager.getScore(for: level))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Complete previous level to unlock")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(isUnlocked ? levelColor : .gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isUnlocked ? levelBackgroundColor : Color.gray.opacity(0.1))
                    .shadow(color: isUnlocked ? levelColor.opacity(0.3) : .clear, radius: 8, x: 0, y: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isUnlocked ? levelColor : Color.gray.opacity(0.3), lineWidth: 2)
            )
        }
        .disabled(!isUnlocked)
        .fullScreenCover(isPresented: $showQuiz) {
            QuizView(level: level)
                .environmentObject(progressManager)
        }
        .pulse(isUnlocked && showPulse)
    }
}
