//
//  ReviewAnswer.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-23.
//

import SwiftUI

struct ReviewAnswersView: View {
    let questions: [Quiz]
    let userAnswers: [Int?]
    let onClose: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(questions.indices, id: \.self) { index in
                        ReviewAnswerCard(
                            questionNumber: index + 1,
                            question: questions[index],
                            userAnswer: index < userAnswers.count ? userAnswers[index] : nil
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Review Answers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onClose()
                    }
                    .tint(.primary)
                }
            }
        }
    }
}



// MARK: - Review Option View
struct ReviewOptionView: View {
    let text: String
    let isUserAnswer: Bool
    let isCorrectAnswer: Bool
    
    var backgroundColor: Color {
        if isCorrectAnswer {
            return Color.green.opacity(0.2)
        } else if isUserAnswer {
            return Color.red.opacity(0.2)
        }
        return Color.gray.opacity(0.05)
    }
    
    var borderColor: Color {
        if isCorrectAnswer {
            return .green
        } else if isUserAnswer {
            return .red
        }
        return .gray.opacity(0.3)
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            if isCorrectAnswer {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else if isUserAnswer {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: isUserAnswer || isCorrectAnswer ? 2 : 1)
        )
    }
}
