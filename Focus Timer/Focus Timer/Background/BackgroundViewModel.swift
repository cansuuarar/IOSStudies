//
//  BackgroundViewModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 2.01.2025.
//

import AVFoundation

protocol BackgroundViewModelDelegate: AnyObject {}

final class BackgroundViewModel {
    weak var backgroundDelegate: BackgroundViewModelDelegate?
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(name: String) {
        if name == "Close" {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }
        guard let url = Bundle.main.url(forResource: name, withExtension: Extension.soundMp3.rawValue) else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {}
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
    
    func saveToUserdefaults(soundName: String) {
        //UserDefaults.standard.set(soundName, forKey: Key.soundKey.rawValue)
    }
}

