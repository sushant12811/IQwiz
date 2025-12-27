//
//  QuizView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-21.
//

import SwiftUI

struct JuniorDevQuizView: View {
    @Environment(AudioPlayerManager.self) var audioManager: AudioPlayerManager
    @Environment(ViewModel.self) var viewModel: ViewModel
    @State private var showBottomButton = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()

                    //Score
                    HStack {
                        Spacer()
                        Text("Score: \(viewModel.score)")
                            .font(.largeTitle).fontWeight(.black)
                            .animation(
                                .bouncy(duration: 0.4),
                                value: viewModel.score
                            )

                        Spacer()
                    }
                    .transition(.move(edge: .top))

                    //ProgressView
                    ProgressView(
                        value: Float(viewModel.currentIndex),
                        total: Float(viewModel.quiz.count)
                    )
                    .tint(.optionsBlue)

                    if let quiz = viewModel.currentQuiz {

                        VStack {
                            Text(quiz.question)
                                .font(.title3)

                            //Options
                            ForEach(quiz.options.indices, id: \.self) { index in
                                Button {
                                    viewModel.selectedAnswer(of: index)
                                    playCorrectnWrong()
                                    viewModel.nextQuestion()
                                } label: {
                                    Text(quiz.options[index])
                                        .optionButtonModifier(
                                            color: viewModel.AnswerOptionsColor(
                                                index: index
                                            ),
                                            selected: viewModel.currentIndex  //animation
                                        )
                                }
                                .disabled(viewModel.selectedAnswerIndex != nil)
                            }
                            .animation(
                                .linear(duration: 0.5),
                                value: viewModel.selectedAnswerIndex
                            )
                        }
                        Spacer()
                    }
                }
                .navigationBarBackButtonHidden()
                .padding()
                .onAppear {
                    audioManager.playBackgroundMusic(
                        soundName: "backgroundLoop",
                        soundType: "mp3"
                    )
                }
            }
        }
    }

    //MARK: Play sound for Correct and Wrong answer
    private func playCorrectnWrong() {
        if viewModel.selectedAnswerIndex == viewModel.correctAnswerOption {
            audioManager.playSound(soundName: "correctAnswer", soundType: "mp3")
        } else {
            audioManager.playSound(soundName: "wrongAnswer", soundType: "mp3")
        }
    }

}

#Preview {
    JuniorDevQuizView()
        .environment(AudioPlayerManager())
        .environment(ViewModel())
}
