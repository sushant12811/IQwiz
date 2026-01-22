//
//  AudioPlayerManager.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-22.
//

import AVFoundation

@Observable
class AudioPlayerManager {
    var audioPlayer: AVAudioPlayer?
    var backgroundPlayer: AVAudioPlayer?
    
    private var targetVolume: Float = 0.1

    //MARK: SET UP AUDIO
    func setAudio(enabled: Bool) {
        targetVolume = enabled ? 0.1 : 0.0
        backgroundPlayer?.volume = targetVolume
        audioPlayer?.volume = targetVolume
    }

    //MARK: SOUND EFFECT
    func playSound(soundName: String, soundType: String) {
        guard let audioPath = Bundle.main.path(
            forResource: soundName,
            ofType: soundType
        ) else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: audioPath))
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.volume = targetVolume
            audioPlayer?.play()
        } catch {
            print("Loading sound failed \(error)")
        }
    }
    
//MARK: BACKGROUND MUSIC
    func playBackgroundMusic(soundName: String, soundType: String) {
        guard let audioPath = Bundle.main.path(
            forResource: soundName,
            ofType: soundType
        ) else { return }

        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: URL(filePath: audioPath))
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = targetVolume
            backgroundPlayer?.play()
        } catch {
            print("Loading sound failed \(error)")
        }
    }
    
    func stopSoundEffect() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
