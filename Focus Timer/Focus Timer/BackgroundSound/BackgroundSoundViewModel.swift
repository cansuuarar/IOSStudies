//
//  BackgroundSoundViewModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 27.12.2024.
//

import Foundation
import AVFoundation

protocol BackgroundSoundViewModelDelegate: AnyObject {
    
}

final class BackgroundSoundViewModel {
    weak var backgroundSoundDelegate : BackgroundSoundViewModelDelegate?
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(name: String) {
        if name == "Close" {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
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
        UserDefaults.standard.set(soundName, forKey: Key.soundKey.rawValue)
    }
}


