//
//  Extension.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-22.
//

import SwiftUI


//MARK: Text: OPTION Button Modifier
extension Text{
    func optionButtonModifier(color: Color, selected option: Int) -> some View {
          self
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow( color:Color.black.opacity(0.3),radius: 2)
            .animation(.easeInOut(duration: 0.25), value: option)
    }
    
    // infoModifier
    func infoModifier() -> some View {
        self
            .font(.headline)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .transition(.opacity)
    }
}

//MARK: Button Modifier
extension  Button {
    func buttonModifier(foreground: Color, backgroundClr: Color, font: Font)-> some View {
        self
            .padding()
            .font(font).fontWeight(.medium)
            .background(backgroundClr)
            .foregroundColor(foreground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow( color:Color.black.opacity(0.3),radius: 2)
    }
    
   
}

//MARK: Case for levels
enum RankedUser: String, CaseIterable, Hashable{
    case legend, master , champion, beginner , starter
}

extension RankedUser{
    static func rank(for score: Int, with fullscore : Int)-> RankedUser{
        if score == fullscore{
           return  .legend
        }else if score > fullscore/Int(1.5){
            return .master
        }else if score > fullscore/Int(2){
            return .champion
        }else if score > 0 {
            return .beginner
        }else{
            return .starter
        }
    }
}

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
                    scale = 1.08
                }
            }
            
    }
}

extension View {
    func pulse(_ active: Bool) -> some View {
        active ? AnyView(self.modifier(PulseEffect())) : AnyView(self)
            
    }
}



