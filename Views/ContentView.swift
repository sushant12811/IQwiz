//
//  ContentView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel : ViewModel
    @State private var headerViewAnimation = false
    @State private var showAlertQuit = false
    @Environment(\.verticalSizeClass) var vSize
    @AppStorage("highScore") private var highScore = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    //Header View-LOGO
                    if viewModel.viewStatus != .finishedView && vSize == .regular{
                        HeaderView()
                            .transition(.move(edge: .top))
                    }
                    //high score
                    if viewModel.viewStatus == .finishedView || viewModel.viewStatus == .homeView {
                        Text("High Score: \(highestScore())")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    switch viewModel.viewStatus {
                    case .onBaordView:
                        OnboardingView()
                    case .homeView:
                        HomeView()
                            .transition(.scale.combined(with: .opacity))
                    case .quizView:
                        JuniorDevQuizView()
                    case .finishedView:
                        FinishedView()
                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                    
                    Spacer()
                }
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.isFinished)
                .onAppear {
                    withAnimation {
                        headerViewAnimation = true
                    }
                }
            //Quit Button with condition and state
                .toolbar {
                    if viewModel.viewStatus == .quizView {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button{
                                showAlertQuit = true
                                viewModel.hasShownPulse = true
                            }label: {
                                Image(
                                    systemName:"rectangle.portrait.and.arrow.right"
                                )
                                .font(.headline).fontWeight(.semibold)
                                .foregroundStyle(.red)
                                .backgroundStyle(.white)
                                .pulse(
                                    viewModel.currentIndex == 1 && !viewModel.hasShownPulse
                                    )
                            }
                        }
                    }
                }
            //Quit alert and quit function
                .alert("Quit", isPresented: $showAlertQuit) {
                    Button("Cancel", role: .cancel) {
                            showAlertQuit = false
                        }
                    Button("Quit", role: .destructive) {
                            viewModel.quitQuiz()
                        }
                } message: {
                    Text("Are you sure you want to quit? Your progress will be lost.")
                }
                
            }

        }
    //MARK: High Score
    private func highestScore() -> Int{
        if viewModel.score > highScore{
            highScore = viewModel.score
        }
        return highScore
    }
}

#Preview {
    ContentView()
        .environment(AudioPlayerManager())
        .environment(ViewModel())

}
