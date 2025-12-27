//
//  ReviewAnswer.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-23.
//

import SwiftUI

struct ReviewAnswerView: View {
    @Environment(ViewModel.self) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Review Your Answers")
                .font(.largeTitle.bold())
                .padding()
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.quiz, id: \.id) { question in
                        let index = viewModel.quiz.firstIndex(where: { $0.id == question.id }) ?? 0
                        //Questions
                        VStack(alignment: .leading, spacing: 8) {
                            Text(question.question)
                                .font(.headline)
                            //Answers
                            ForEach(question.options.indices, id: \.self) { optionIndex in
                                Text(question.options[optionIndex])
                                    .optionButtonModifier(color: viewModel.reviewOptionColor(questionIndex: index, optionIndex: optionIndex), selected: viewModel.currentIndex)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
       


#Preview {
    ReviewAnswerView()
        .environment(ViewModel())
}
