//
//  ContentView.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedMode") private var selectedMode: DisplayMode = .system
    @AppStorage("audioOn") private var audioOn: Bool = true
    @AppStorage("firstTimeOpen") private var firstTimeOpen: Bool = true
    @Environment(AudioPlayerManager.self) var audioManager: AudioPlayerManager

    var body: some View {
        NavigationStack{
            if firstTimeOpen {
                OnboardingView{
                    firstTimeOpen = false
                }
            }else{
                LevelSelectionView()
                    .toolbar{
                        toolBarmenu()
                    }
               }
            }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(selectedMode.colorMode)
        .onAppear {
            audioManager.setAudio(enabled: audioOn)
                audioManager.playBackgroundMusic(
                    soundName: "backgroundLoop",
                    soundType: "mp3"
                )
        }
                
    }
    
    //MARK: MENU OPTIONS
    @ToolbarContentBuilder
    func toolBarmenu() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu("MenuOptions", systemImage: "ellipsis.circle"){
                Button{
                    audioOn.toggle()
                    audioManager.setAudio(enabled: audioOn)
                }label: {
                    Label("Mute", systemImage: audioOn ?  "speaker.wave.2.fill" : "speaker.slash.fill" )
                }
                
                Menu("Mode", systemImage: "circle.lefthalf.filled.inverse"){
                    Picker("Select Mode", selection: $selectedMode){
                        ForEach(DisplayMode.allCases, id:\.self){ mode in
                            Label(mode.rawValue.capitalized, systemImage: mode.icon)
                                .tag(mode)

                        }
                    }
                   
                    }
            }
            .tint(.primary)
        }
        
    }
}

#Preview {
    ContentView()
}
