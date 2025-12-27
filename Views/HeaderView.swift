//
//  HeaderView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing:0){
            Text("|")
                .font(.system(size: 80))
                .fontWeight(.black)
            Text("Qwiz")
                .font(.largeTitle)
                .padding(.top,55)
        }
        .padding()
    }
}

#Preview {
    HeaderView()
}
