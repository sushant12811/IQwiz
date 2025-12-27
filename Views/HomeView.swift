//
//  HomeView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-23.
//

import SwiftUI

struct HomeView: View {
    @Environment(ViewModel.self) var viewModel : ViewModel
    @State private var navigationPath = NavigationPath()
    @State private var midAndSeniorDevQuiz: Bool = true
    var body: some View {
        
        NavigationStack{
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack(spacing: 50){
             // Start-quiz Button
                    ZStack {
                        Button("Start Quiz- Junior Level"){
                            viewModel.restartQuiz()
                        }
                        .buttonModifier(
                            foreground: .button,
                            backgroundClr: .optionsBlue,
                            font: .title2
                        )
                        .pulse(!viewModel.hasShownPulse)
                        if !viewModel.hasShownPulse{
                            Text("Tap here")
                                .infoModifier()
                                .offset(x:70, y:-50)
                        }
                    }
                }.padding()
            }
        }
    }
}


#Preview {
    HomeView()
        .environment(ViewModel())
}
