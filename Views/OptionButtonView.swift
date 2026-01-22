//
//  OptionButtonView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2026-01-21.
//

import SwiftUI

struct OptionButtonView: View {
    let text: String
    let index: Int
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void

    var backgroundColor: Color {
        if !showResult {
            return isSelected ? Color.blue.opacity(0.2) : .clear
        }

        if isSelected {
            return isCorrect ? Color.green.opacity(0.3) : Color.red.opacity(0.3)
        }

        if isCorrect {
            return Color.green.opacity(0.3)
        }

        return Color.gray.opacity(0.2)
    }

    var borderColor: Color {
        if !showResult {
            return isSelected ? .blue : .gray.opacity(0.2)
        }

        if isSelected {
            return isCorrect ? .green : .red
        }

        if isCorrect {
            return .green
        }

        return .gray.opacity(0.2)
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)

                Spacer()

                if showResult {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else if isSelected {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(showResult)
        
    }
    
   
}
