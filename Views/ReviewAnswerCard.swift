//
//  ReviewAnswerCard.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2026-01-21.
//

import Foundation
import SwiftUI

struct ReviewAnswerCard: View {
    let questionNumber: Int
    let question: Quiz
    let userAnswer: Int?
    
    var isCorrect: Bool {
        guard let userAnswer = userAnswer,
              let correctIndex = question.correctAnswerIndex else {return false}
               let result = userAnswer == correctIndex
               return result
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text("Question \(questionNumber)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    Text(isCorrect ? "Correct" : "Incorrect")
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isCorrect ? .green : .red)
            }
            
            // Question
            Text(question.question)
                .font(.body)
                .fontWeight(.medium)
            
            // Options
            VStack(spacing: 8) {
                ForEach(question.options.indices, id: \.self) { index in
                    ReviewOptionView(
                        text: question.options[index],
                        isUserAnswer: userAnswer == index,
                        isCorrectAnswer: index == question.correctAnswerIndex

                    )
                }
            }
            
            // Hint if available
            if let hint = question.hint, !hint.isEmpty {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(.yellow)
                    Text(hint)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.yellow.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(uiColor: .systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}
