//
//  BackgroundViewModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 2.01.2025.
//
import UIKit
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
        guard let url = Bundle.main.url(forResource: name, withExtension: AudioExtension.soundMp3.rawValue) else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {}
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
    
    func saveToUserdefaults(backgroundModel: BackgroundModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(backgroundModel) {
            UserDefaults.standard.set(encoded, forKey: "backgroundModelKey")
        }
    }
}

