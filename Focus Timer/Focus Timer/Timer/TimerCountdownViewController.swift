//
//  ViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 24.12.2024.
//

import UIKit
import CoreImage

final class TimerCountdownViewController: UIViewController, TimerViewModelDelegate {
    @IBOutlet private weak var backgroundButton: UIButton!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var startButton: UIButton!
    private var backgroundImageView: UIImageView!
    private var viewModel = TimerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(title: .none, image: UIImage(named: "time"), tag: 1)
        viewModel.timerDelegate = self
        updateTimeLabel()
        setupBackgroundImageView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .myNotification, object: nil)
        applyGradientBackground()
        viewModel.changeBackgroundImage()
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.7
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        backgroundButton.imageView?.contentMode = .scaleAspectFit
        //backgroundButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        //backgroundButton.imageView?.image = UIImage(named: "back.png")
    }
    
    func updateImage(_ image: UIImage) {
        backgroundImageView.image = image
    }
    
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
                UIColor(hex: "#f0f4f8").cgColor,
                UIColor(hex: "#d6d2cf").cgColor,
                UIColor(hex: "#e0dedb").cgColor,
                UIColor(hex: "#dad8d1").cgColor
            ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction private func increaseMinutes(_ sender: Any) {
        viewModel.increaseMinute()
    }
    
    @IBAction private func decreaseMinutes(_ sender: Any) {
        viewModel.decreaseMinute()
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
        
        //tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction private func stopButtonPressed(_ sender: UIButton) {
        tabBarController?.tabBar.isHidden = false
        viewModel.stopTimer()
        sender.setImage(UIImage(systemName: "stop"), for: .normal)
        if startButton.currentImage == UIImage(systemName: "pause.fill") {
            startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @IBAction func backgroundButtonpressed(_ sender: Any) {
        guard let backgroundvc = storyboard?.instantiateViewController(withIdentifier: "backgroundVC") as? BackgroundViewController else { return }
        navigationController?.present(backgroundvc, animated: true)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            if let userInfo = notification.userInfo, let image = userInfo["image"] as? UIImage {
                self.backgroundImageView.image = image
            }
        }
    }
    
    func updateTimeLabel() {
        DispatchQueue.main.async { [weak self] in
            self?.timerLabel.text =
            String(format:"%02i:%02i:%02i", Constant.hour, Constant.minute, Constant.second)
        }
    }
}


