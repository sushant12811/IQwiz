//
//  AudioPlayerManager.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-22.
//

import AVFoundation

@Observable
class AudioPlayerManager{
    var audioPlayer: AVAudioPlayer?
    var backgroundPlayer : AVAudioPlayer?
    
    //func : play sound for correct or wrong
    func playSound(soundName: String, soundType: String){
        guard let audioPath = Bundle.main.path(forResource: soundName, ofType: soundType) else{
            print("Sound file not found: \(soundName), of \(soundType)")
            return
        }
        let url = URL(filePath: audioPath)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 0.3
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
        }catch{
            print ("Loading sound failed \(error.localizedDescription)")
            
        }
    }
    
    //Func: play sound for backgrond
    func playBackgroundMusic(soundName: String, soundType: String){
        guard let audioPath = Bundle.main.path(forResource: soundName, ofType: soundType) else{
            print("Sound file not found: \(soundName), of \(soundType)")
            return
        }
        let url = URL(filePath: audioPath)
        
        do{
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.1
            backgroundPlayer?.play()
        }catch{
            print ("Loading sound failed \(error.localizedDescription)")
            
        }
    }
}
