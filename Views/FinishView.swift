//
//  FinishedView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-21.
//

import SwiftUI

struct FinishedView: View {
    
    @Environment(AudioPlayerManager.self) var audioPlayerManager
    @Environment(ViewModel.self) var viewModel
    @State private var navigationPath = NavigationPath()
    @State private var showReview = false
    @Environment(\.verticalSizeClass) private var vSize
    @AppStorage("audioOn") private var audioOn: Bool = true

    var body: some View {
        let regularSize = vSize == .regular
        let currentScore = viewModel.scores[viewModel.quizLevel ?? .iosJunior, default: 0]

        
        ScrollView {
            VStack{
                //IMAGE - Fire WORKs
                HStack{
                    Image(systemName: "fireworks")
                        .resizable()
                        .scaledToFit()
                        .frame(height: regularSize ? 150 : 100)
                        .foregroundStyle(.yellow)
                        .symbolEffect(.pulse)
                    
                    Image(systemName: "fireworks")
                        .resizable()
                        .scaledToFit()
                        .frame(height:  regularSize ? 150 : 100)
                        .foregroundStyle(.yellow)
                        .symbolEffect(.pulse)
                }
                //Users- Level
                Text(
                    "✨\(RankedUser.rank(for: currentScore, with: viewModel.quiz.count).rawValue.capitalized)✨"
                )
                .font(
                    .system(
                        size:  regularSize ? 50 : 30,
                        weight: .black,
                        design: .default
                    )
                )
                .pulse(viewModel.isFinished)
                
                
                Text("Quiz Finished")
                    .font(regularSize ? .largeTitle :  .title2)
                    .padding()
                //Score
                Text("Your Score: \(currentScore)")
                    .font(regularSize ? .title : .title2)
        
                HStack(spacing: 30){
                    //Restart- button
                    Button("Restart"){
                        viewModel.startQuiz(level: viewModel.quizLevel ?? .iosMid )
                    }
                    .buttonModifier(
                        foreground: .customOrange,
                        backgroundClr: .optionsBlue,
                        font: regularSize ? .title2 : .title3
                    )
                    //Review-button
                    Button("Review"){
                        showReview = true
                    }
                    .buttonModifier(
                        foreground: .customOrange,
                        backgroundClr: .optionsBlue,
                        font: regularSize ? .title2 : .title3
                    )
                }
                .padding(.bottom,30)
                //Exit- button
                Button("Exit"){
                    viewModel.quitQuiz()
                    
                }
                .buttonModifier(
                    foreground: .customOrange,
                    backgroundClr: .optionsBlue,
                    font: regularSize ? .title2 : .title3
                )
                Spacer()
            }
            .frame(
                maxWidth: .infinity ,
                maxHeight: regularSize ? .infinity : 250
            )
            .onAppear {
            
                audioPlayerManager
                    .playSound(soundName: "finished", soundType: "mp3")
                audioPlayerManager.setAudio(enabled: audioOn)
                
            }
            .sheet(isPresented: $showReview) {
                ReviewAnswerView()
            }
        }
        
    }
}

#Preview {
    FinishedView()
        .environment(AudioPlayerManager())
        .environment(ViewModel(level: .iosJunior))
}
