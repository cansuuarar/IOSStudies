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
    private var backgroundImageView: UIImageView!
    private var viewModel = TimerViewModel()
    private var progress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.timerDelegate = self
        updateTimeLabel()
        setupBackgroundImageView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .myNotification, object: nil)
        
    }
    
    private func setupBackgroundImageView() {
        // UIImageView'i programatik olarak ekliyoruz
        backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.contentMode = .scaleAspectFill // Görselin doğru şekilde ekranı kaplamasını sağlar
        backgroundImageView.clipsToBounds = true // Görselin taşmaması için
        
        // UIImageView'ı ekliyoruz
        self.view.addSubview(backgroundImageView)
        
        // Diğer tüm objelerin üstünde olmaması için arka plana gönderiyoruz
        self.view.sendSubviewToBack(backgroundImageView)
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
    
    @objc func handleNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            // Background image view'in arka plana gelmesini sağlıyoruz
            if let userInfo = notification.userInfo, let image = userInfo["image"] as? UIImage {
                // Arka planı değiştirmek için gelen image'ı kullanıyoruz
                self.backgroundImageView.image = image
            }
            
            
        }
    }
}
