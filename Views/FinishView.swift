//
//  FinishedView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-21.
//

import SwiftUI

struct FinishView: View {
    let score: Int
    let totalQuestions: Int
    let level: QuizLevel
    let onReturnToMenu: () -> Void
    let onReviewAnswers: () -> Void

    @EnvironmentObject var progressManager: QuizProgressManager
    @Environment(AudioPlayerManager.self) var audioPlayerManager

    
    var percentage: Double {
        Double(score) / Double(totalQuestions) * 100
    }
    
    var performanceMessage: String {
        switch percentage {
        case 90...100:
            return "Outstanding! 🎉"
        case 70..<90:
            return "Great job! 👏"
        case 50..<70:
            return "Good effort! 👍"
        default:
            return "Keep practicing! 💪"
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Quiz Complete!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(performanceMessage)
                .font(.title2)
                .foregroundColor(.secondary)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0, to: percentage / 100)
                    .stroke(
                        percentage >= 70 ? Color.green : (percentage >= 50 ? Color.orange : Color.red),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                
                
                
                VStack {
                    Text("\(score)")
                        .font(.system(size: 60, weight: .bold))
                    Text("out of \(totalQuestions)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            
            Text("\(Int(percentage))% Correct")
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
            VStack(spacing:12){
                Button(action: onReviewAnswers) {
                                    HStack {
                                        Image(systemName: "doc.text.magnifyingglass")
                                        Text("Review Answers")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange)
                                    .cornerRadius(12)
                                }
                Button(action: onReturnToMenu) {
                    Text("Return to Menu")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.customBlue)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .onAppear {
            audioPlayerManager
                .playSound(soundName: "finished", soundType: "mp3")
        }
        .padding()
    }
}

