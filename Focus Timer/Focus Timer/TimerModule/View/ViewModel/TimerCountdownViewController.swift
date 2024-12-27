//
//  ViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 24.12.2024.
//

import UIKit

final class TimerCountdownViewController: UIViewController, TimerViewModelDelegate {
    @IBOutlet private weak var timeLabel: UILabel!
    private var viewModel = TimerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.timerDelegate = self
        updateTimeLabel()
    }
    @IBAction func increaseMinutes(_ sender: Any) {
        viewModel.increaseMinute()
    }
    
    @IBAction func decreaseMinutes(_ sender: Any) {
        viewModel.decreaseMinute()
    }
    
    func updateTimeLabel() {
        DispatchQueue.main.async { [weak self] in
            self?.timeLabel.text =
            String(format:"%02i:%02i:%02i", Constant.shared.hour, Constant.shared.minute, Constant.shared.second)
        }
    }
    
    @IBAction private func startButtonPressed(_ sender: Any) {
        viewModel.callTimer()
    }
    
    @IBAction private func stopButtonPressed(_ sender: Any) {
        viewModel.stopTimer()
    }
}
