//
//  Extension.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-22.
//

import SwiftUI


//MARK: PULSE EFFECT
struct PulseEffect: ViewModifier {
    @State private var scale: CGFloat = 1

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 0.8)
                    .repeatForever(autoreverses: true)
                ) {
                    scale = 0.9
                }
            }
    }
}

extension View {
    @ViewBuilder
    func pulse(_ active: Bool) -> some View {
        if active {
            self.modifier(PulseEffect())
        } else {
            self
        }
    }
}




