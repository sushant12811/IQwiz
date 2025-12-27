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
    @State private var showInfo = false
    @Environment(\.verticalSizeClass) var vSize
    let isScreenshotMode = ProcessInfo.processInfo.arguments.contains("SCREENSHOT_MODE")


    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    switch viewModel.fetchResult {
                    case .notStarted:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .success:
                        //Score
                        HStack {
                            Spacer()
                            Text("Score: \(viewModel.score)")
                                .font(vSize == .regular ? .largeTitle : .title2)
                                .fontWeight(.black)
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
                             //Question
                            VStack{
                                Text(
                                    "Q.\(viewModel.currentIndex + 1). \(quiz.question)"
                                )
                                .font(.title3)
                                .lineLimit(2)
                                .frame(minHeight: 48, alignment: .top)
                                //Options - Answers
                                ForEach(
                                    quiz.options.indices,
                                    id: \.self
                                ) { index in
                                    Button {
                                        viewModel.selectedAnswer(of: index)
                                        playCorrectnWrong()
                                        viewModel.nextQuestion()
                                    } label: {
                                        Text(quiz.options[index])
                                            .optionButtonModifier(
                                                color: viewModel
                                                    .AnswerOptionsColor(
                                                        index: index
                                                    ),
                                                selected: viewModel.currentIndex  //animation
                                            )
                                            .pulse(
                                                viewModel.currentIndex == 0 && !viewModel.hasShownPulse && index == 1
                                            )
                                    }
                                    .disabled(
                                        viewModel.selectedAnswerIndex != nil
                                    )
                                       //Instructions onbaord
                                    .overlay {
                                        if !viewModel.hasShownPulse && viewModel.currentIndex == 0 && index == 1  {
                                            Image(systemName: "hand.tap.fill")
                                                .font(.title)
                                                .foregroundStyle(.white)
                                                .offset(x:60 , y: 15)
                                        }
                                            
                                    }
                                }
                                .animation(
                                    .linear(duration: 0.5),
                                    value: viewModel.selectedAnswerIndex)
                                // Info Button
                                HStack{
                                    Spacer()
                                    Button{
                                        showInfo = true
                                    }label: {
                                        Image(systemName: "info.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundStyle(.optionsBlue)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .padding()
                                            .pulse(
                                                viewModel.currentIndex == 0 && !viewModel.hasShownPulse
                                            )
                                    }
                                }
                            }
                        }
                            
                    case .failed(error: let error):
                        Text(error.localizedDescription)
                            .font(.title3)
                            .foregroundStyle(.red)
                    }
                        
                    Spacer()
                        
                }
                .frame(maxWidth: .infinity)
                .padding()
                .onAppear {
                    audioManager.playBackgroundMusic(
                        soundName: "backgroundLoop",
                        soundType: "mp3"
                    )
                    viewModel.selectedAnswerIndex = nil
                    
                }
                .task {
                    viewModel.loadQuizzes()
                }
                .sheet(isPresented: $showInfo, content: {
                    InfoView()
                        .presentationDetents([.height(80), .medium])
                })
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
