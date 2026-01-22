//
//  OnboardingView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-24.
//

import SwiftUI

struct OnboardingView: View {
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            // App Icon or Illustration
            Image(systemName: "brain.head.profile")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.customBlue.gradient)
                .padding(.bottom, 20)
            
            // Title
            Text("Welcome to IQwiz")
                .font(.largeTitle)
                .fontWeight(.bold).fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            
            // Subtitle
            Text("Test your knowledge with engaging quizzes")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            
            // Features List
            VStack(alignment: .center, spacing: 24) {
                
                FeatureRow(
                    icon: "hand.tap.fill",
                    title: "Tap to Answer",
                    description: "Select your answer with a simple tap"
                )
                
                FeatureRow(
                    icon: "info.circle.fill",
                    title: "Get Hints",
                    description: "Tap the info button when you need help"
                )
                
                FeatureRow(
                    icon: "arrow.right.circle.fill",
                    title: "Auto Progress",
                    description: "Moves to the next question automatically"
                )
                
                FeatureRow(
                    icon: "checkmark.circle.fill",
                    title: "Review Answers",
                    description: "See all your results at the end"
                )
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Get Started Button
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onTap()
                }
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.customBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: .customBlue.opacity(0.3), radius: 8, y: 4)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.customBlue.gradient)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView(onTap: {})
}
