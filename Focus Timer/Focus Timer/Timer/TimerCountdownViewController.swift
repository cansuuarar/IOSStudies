//
//  ViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 24.12.2024.
//

import UIKit

final class TimerCountdownViewController: UIViewController, TimerViewModelDelegate {
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet weak var progressView: CircularProgressBar!
    private var viewModel = TimerViewModel()
    private var progress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.timerDelegate = self
        updateTimeLabel()
    }
    
    func setupView() {
        progressView.layer.cornerRadius = progressView.bounds.width / 2
        progressView.layer.masksToBounds = true
        progressView.clipsToBounds = true
    }
    
    @IBAction func increaseMinutes(_ sender: Any) {
        viewModel.increaseMinute()
    }
    
    @IBAction func decreaseMinutes(_ sender: Any) {
        viewModel.decreaseMinute()
    }
    
    func updateTimeLabel() {
        DispatchQueue.main.async { [weak self] in
            self?.timerLabel.text =
            String(format:"%02i:%02i:%02i", Constant.shared.hour, Constant.shared.minute, Constant.shared.second)
        }
    }
    
    func updateCircularProgress(progress: Float) {
        DispatchQueue.main.async { [weak self] in
            self?.progressView.setProgress(to: progress)
        }
    }
    
    @IBAction private func startButtonPressed(_ sender: UIButton) {
        if viewModel.getDidStart() {
            viewModel.pauseTimer()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            viewModel.callTimer()
            viewModel.playSound()
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction private func stopButtonPressed(_ sender: UIButton) {
        viewModel.stopTimer()
        sender.setImage(UIImage(systemName: "stop"), for: .normal)
    }
}
