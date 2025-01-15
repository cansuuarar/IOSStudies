//
//  TimerViewModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 26.12.2024.
//

import Foundation
import AVFoundation
import UIKit

protocol TimerViewModelDelegate: AnyObject {
    func updateTimeLabel()
    //func updateCircularProgress(progress: Float)
    func updateImage(_ image: UIImage)
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
        if Constant.minute < 55 && Constant.hour < 1 {
            Constant.minute += 5
            timerDelegate?.updateTimeLabel()
        } else if Constant.minute == 55 {
            Constant.hour = 1
            Constant.minute = 0
            timerDelegate?.updateTimeLabel()
        }
    }
    
    func decreaseMinute() {
        if Constant.minute > 10 && Constant.minute < 60 {
            Constant.minute -= 5
            timerDelegate?.updateTimeLabel()
        } else if Constant.hour == 1 {
            Constant.minute = 55
            Constant.hour = 0
            timerDelegate?.updateTimeLabel()
        }
    }
    
    func callTimer() {
        if !didStart {
            totalTimeInSeconds = (Constant.hour * 3600) + (Constant.minute * 60) + Constant.second
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            didStart = true
        }
    }
    
    @objc private func fireTimer() {
        elapsedTime += 1
        if Constant.second > 0 {
            Constant.second -= 1
        }
        else if Constant.minute > 0 && Constant.second == 0 {
            Constant.minute -= 1
            Constant.second = 59
        }
        else if Constant.hour > 0 && Constant.minute == 0 && Constant.second == 0 {
            Constant.hour -= 1
            Constant.minute = 59
            Constant.second = 59
        }
        timerDelegate?.updateTimeLabel()
        //let progress = Float(elapsedTime) / Float(totalTimeInSeconds)
        //timerDelegate?.updateCircularProgress(progress: progress)
        
        if Constant.hour == 0 && Constant.minute == 0 && Constant.second == 0 {
            timeOverPlaySound()
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.invalidate()
        Constant.hour = 0
        Constant.minute = 25
        Constant.second = 0
        elapsedTime = 0
        didStart = false
        timerDelegate?.updateTimeLabel()
        //timerDelegate?.updateCircularProgress(progress: 0.0)
        audioPlayer?.stop()
    }
    
    func pauseTimer() {
        if didStart {
            timer.invalidate()  // Timer'ı duraklatıyoruz
            didStart = false
            timerDelegate?.updateTimeLabel() // UI'yi güncelleriz
            audioPlayer?.stop()
            //let progress = Float(elapsedTime) / Float(totalTimeInSeconds)
            //timerDelegate?.updateCircularProgress(progress: progress)
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
        guard let savedBackgroundModel = UserDefaults.standard.data(forKey: Key.soundKey.rawValue) else { return }
        let decoder = JSONDecoder()
        guard let decodedModel = try? decoder.decode(BackgroundModel.self, from: savedBackgroundModel) else { return }
        
        do {
            guard let url = Bundle.main.url(forResource: decodedModel.soundName, withExtension: AudioExtension.soundMp3.rawValue) else { return }
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {}
    }
    
    func changeBackgroundImage() {
        guard let savedBackgroundModel = UserDefaults.standard.data(forKey: Key.soundKey.rawValue) else { return }
        let decoder = JSONDecoder()
        guard let decodedModel = try? decoder.decode(BackgroundModel.self, from: savedBackgroundModel) else { return }
        if let image = decodedModel.image {
            timerDelegate?.updateImage(image)
        }
    }

}
