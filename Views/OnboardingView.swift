//
//  OnboardingView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(ViewModel.self) private var viewModel : ViewModel
    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to IQwiz")
                .font(.largeTitle.bold())

            Text(
                "➡️ Tap an answer\n➡️ Tap info button for more hint \n➡️ Auto moves to next question\n➡️ Review answers at the end"
            )
            .font(.title2)
            .multilineTextAlignment(.leading)

            Button("Next") {
                withAnimation(.easeInOut(duration: 0.3)){
                    viewModel.viewStatus = .homeView
                }
            }
            .padding()
            .background(.optionsBlue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
        .environment(ViewModel())
}
