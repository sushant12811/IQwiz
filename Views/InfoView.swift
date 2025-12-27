//
//  InfoView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-25.
//

import SwiftUI

struct InfoView: View {
    @Environment(ViewModel.self) private var viewModel : ViewModel

    var body: some View {
        //Info for each question
            VStack(alignment: .leading) {
                if let quiz = viewModel.currentQuiz {
                    Text(quiz.hint ?? "Info for each question not available at the moment")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
            }
                Spacer()
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
       
    }
}

#Preview {
    InfoView()
        .environment(ViewModel())
}
