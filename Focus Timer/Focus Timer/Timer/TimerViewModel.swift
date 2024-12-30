//
//  TimerViewModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 26.12.2024.
//

import Foundation
import AVFoundation

protocol TimerViewModelDelegate: AnyObject {
    func updateTimeLabel()
    func updateCircularProgress(progress: Float)
}

final class TimerViewModel {
    weak var timerDelegate: TimerViewModelDelegate?
    private var audioPlayer: AVAudioPlayer?
    private var timer = Timer()
    private var didStart = false
    private var totalTimeInSeconds: Int = 0
    private var elapsedTime: Int = 0
    
    func getDidStart() -> Bool {
        return didStart
    }
    
    func increaseMinute() {
        if Constant.shared.minute < 55 && Constant.shared.hour < 1 {
            Constant.shared.minute += 5
            timerDelegate?.updateTimeLabel()
        } else if Constant.shared.minute == 55 {
            Constant.shared.hour = 1
            Constant.shared.minute = 0
            timerDelegate?.updateTimeLabel()
        }
    }
    
    func decreaseMinute() {
        if Constant.shared.minute > 10 && Constant.shared.minute < 60 {
            Constant.shared.minute -= 5
            timerDelegate?.updateTimeLabel()
        } else if Constant.shared.hour == 1 {
            Constant.shared.minute = 55
            Constant.shared.hour = 0
            timerDelegate?.updateTimeLabel()
        }
    }
    
    func callTimer() {
        if !didStart {
            totalTimeInSeconds = (Constant.shared.hour * 3600) + (Constant.shared.minute * 60) + Constant.shared.second
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            didStart = true
        }
    }
    
    @objc private func fireTimer() {
        elapsedTime += 1
        if Constant.shared.second > 0 {
            Constant.shared.second -= 1
        }
        else if Constant.shared.minute > 0 && Constant.shared.second == 0 {
            Constant.shared.minute -= 1
            Constant.shared.second = 59
        }
        else if Constant.shared.hour > 0 && Constant.shared.minute == 0 && Constant.shared.second == 0 {
            Constant.shared.hour -= 1
            Constant.shared.minute = 59
            Constant.shared.second = 59
        }
        timerDelegate?.updateTimeLabel()
        let progress = Float(elapsedTime) / Float(totalTimeInSeconds)
        timerDelegate?.updateCircularProgress(progress: progress)
        
        if Constant.shared.hour == 0 && Constant.shared.minute == 0 && Constant.shared.second == 0 {
            timeOverPlaySound()
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.invalidate()
        Constant.shared.hour = 0
        Constant.shared.minute = 1
        Constant.shared.second = 0
        elapsedTime = 0
        didStart = false
        timerDelegate?.updateTimeLabel()
        timerDelegate?.updateCircularProgress(progress: 0.0)
        audioPlayer?.stop()
    }
    
    func pauseTimer() {
        if didStart {
            timer.invalidate()  // Timer'ı duraklatıyoruz
            didStart = false
            timerDelegate?.updateTimeLabel() // UI'yi güncelleriz
            audioPlayer?.stop()
            let progress = Float(elapsedTime) / Float(totalTimeInSeconds)
            timerDelegate?.updateCircularProgress(progress: progress)
        }
    }
    
    func resumeTimer() {
        if !didStart {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            didStart = true
        }
    }
    
    func timeOverPlaySound() {
        guard let url = Bundle.main.url(forResource: "beep", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {}
    }
    
    
    func playSound() {
        guard let savedSound = UserDefaults.standard.string(forKey: Key.soundKey.rawValue) else { return }
        do {
            guard let url = Bundle.main.url(forResource: savedSound, withExtension: Extension.sound.rawValue) else { return }
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {}
    }
    
    
}
