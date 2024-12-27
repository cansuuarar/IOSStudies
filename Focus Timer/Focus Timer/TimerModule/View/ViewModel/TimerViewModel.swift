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
}

final class TimerViewModel {
    weak var timerDelegate: TimerViewModelDelegate?
    var audioPlayer: AVAudioPlayer?
    private var timer = Timer()
    private var didStart = false
    
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
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            didStart = true
        }
    }
    
    @objc private func fireTimer() {
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
        
        if Constant.shared.hour == 0 && Constant.shared.minute == 0 && Constant.shared.second == 0 {
            timeOverPlaySound()
        }
    }
    
    func stopTimer() {
        timer.invalidate()
        Constant.shared.hour = 0
        Constant.shared.minute = 1
        Constant.shared.second = 0
        didStart = false
        timerDelegate?.updateTimeLabel()
    }
    
    func timeOverPlaySound() {
        guard let url = Bundle.main.url(forResource: "beep", withExtension: "mp3") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                
            }
    }

}
