//
//  IOSQuizApp.swift
//  IOSQuiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//

import SwiftUI

@main
struct IQwizApp: App {
    @State private var audioManager = AudioPlayerManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(audioManager)
        }
    }
}
