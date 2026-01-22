//
//  IQwizApp.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//
import SwiftUI

@main
struct IQwizApp: App {
    @State private var audioManager = AudioPlayerManager()
    @State private var showLaunch = true

    var body: some Scene {
        WindowGroup {
            if showLaunch {
                ZStack{
                    HeaderView()
                }
                .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                showLaunch = false
                            }
                        }
                    }
            }else{
             ContentView()
                .environment(audioManager)
                .onAppear {
                    NotificationManager.shared.requestPermissionAndScheduleDaily()
                }
                    
            }
            
        }
    }
}

