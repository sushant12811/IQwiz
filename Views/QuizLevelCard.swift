//
//  LevelCardView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2026-01-05.
//

import SwiftUI

struct LevelCardView: View {
    let title: String
    let score: String
    let color: Color
    @Environment(\.verticalSizeClass) var vSize
    @Environment(ViewModel.self) var viewModel
    let onTap: () -> Void
    
    var body: some View {
        let regularSize = vSize == .regular

        ZStack(alignment: .bottom ){
            color
            VStack {
                Spacer()
                Button(title) {
                    onTap()
                }
                .buttonModifier(foreground: .customOrange, backgroundClr: .optionsBlue, font: .title2)
                .padding()

                Spacer()

                Text(score)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.gray.opacity(0.5))
            }
//            .overlay {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(color)
//            }
            }
            .frame(width: regularSize ? 160 : 300 , height: regularSize ? 200 : 180)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 15)
                    .fill(Color.background)
                    .shadow(color:Color.black.opacity(0.4), radius: 2)
            )
            .padding()
        
        
        }
        
        
    
}

#Preview {
    LevelCardView(title: "Mid-Level", score: "100", color: .clear, onTap: {})
}
