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


    var body: some View {
        let regularSize = vSize == .regular
        
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
                    "✨\(RankedUser.rank(for: viewModel.score, with: viewModel.quiz.count).rawValue.capitalized)✨"
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
                Text("Your Score: \(viewModel.score)")
                    .font(regularSize ? .title : .title2)
        
                HStack(spacing: 30){
                    //Restart- button
                    Button("Restart"){
                        viewModel.restartQuiz()
                    }
                    .buttonModifier(
                        foreground: .button,
                        backgroundClr: .optionsBlue,
                        font: regularSize ? .title2 : .title3
                    )
                    //Review-button
                    Button("Review"){
                        showReview = true
                    }
                    .buttonModifier(
                        foreground: .button,
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
                    foreground: .button,
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
        .environment(ViewModel())
}
