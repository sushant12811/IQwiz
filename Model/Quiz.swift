//
//  Quiz.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//

import Foundation
import SwiftUI

struct Quiz: Codable{
    let id : Int
    let question: String
    let options: [String]
    let correctAnswerIndex: Int?
    let hint: String?
    var isFavourite: Bool?
    
    init(id: Int, question: String, options: [String], correctAnswerIndex: Int? = nil, hint: String? = nil ,isFavourite: Bool? = false) {
        self.id = id
        self.question = question
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
        self.hint = hint
        self.isFavourite = isFavourite
    }
    
    static let samplQuestion : [Quiz] = [
        Quiz(id: 1, question: "What does the async keyword indicate in Swift?", options: [
            "Code runs faster",
            "Code runs on a new thread",
            "Function can suspend execution",
            "Function runs only once"
        ],
             correctAnswerIndex: 2,
             hint: "Hint"
            )
    ]
}
enum DisplayMode: String, Hashable, CaseIterable{
    case light, dark, system
    
    var icon: String{
        switch self {
        case .light :
            "sun.max.fill"
        case .dark:
            "moon.stars.fill"
        case .system:
            "circle.lefthalf.filled"
        }
    }
    
    var colorMode: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .none
        }
    }
    
}

