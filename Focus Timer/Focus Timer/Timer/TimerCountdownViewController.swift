//
//  ViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 24.12.2024.
//

import UIKit

final class TimerCountdownViewController: UIViewController, TimerViewModelDelegate {
   
    @IBOutlet private weak var backgroundButton: UIButton!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    private var backgroundImageView: UIImageView!
    private var viewModel = TimerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "timer"), tag: 1)
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
    }
    
    func updateImage(_ image: UIImage) {
        backgroundImageView.image = image
    }
    
    func updateTabBar(_ soundName: String) {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        tabBar.alpha = 0.5
        switch soundName {
        case Background.rain.rawValue:
            tabBar.backgroundColor = UIColor(hex: "#5A3B27")
        case Background.cafe.rawValue:
            tabBar.backgroundColor = UIColor(hex: "#534835")
        case Background.forest.rawValue:
            tabBar.backgroundColor = UIColor(hex: "#75665C")
        case Background.library.rawValue:
            tabBar.backgroundColor = UIColor(hex: "#D3C4A0")
            tabBar.alpha = 0.7
        case Background.ocean.rawValue:
            tabBar.backgroundColor = UIColor(hex: "#5C5652")
        case Background.wind.rawValue:
            tabBar.backgroundColor = UIColor(hex: "#34464A")
        default:
            tabBar.tintColor = UIColor.lightGray
        }
    }
    
    func disableBackgroundButton() {
        backgroundButton.isEnabled = false
        let alertController = UIAlertController(title: "Complete your flow to change your space 🏁", message: .none, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title:  "OK", style: .default))
        self.present(alertController, animated: true)
        backgroundButton.isEnabled = true
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
        increaseButton.isHidden = true
        decreaseButton.isHidden = true
        if viewModel.getDidStart() {
            viewModel.pauseTimer()
            sender.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            viewModel.callTimer()
            viewModel.playSound()
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction private func stopButtonPressed(_ sender: UIButton) {
        increaseButton.isHidden = false
        decreaseButton.isHidden = false
        viewModel.stopTimer()
        sender.setImage(UIImage(systemName: "stop"), for: .normal)
        if startButton.currentImage == UIImage(systemName: "pause.fill") {
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }
    
    @IBAction func backgroundButtonpressed(_ sender: Any) {
        if viewModel.getAudioPlayer().isPlaying {
            disableBackgroundButton()
        }
        
        guard let backgroundvc = storyboard?.instantiateViewController(withIdentifier: "backgroundVC") as? BackgroundViewController else { return }
        navigationController?.present(backgroundvc, animated: true)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            if let userInfo = notification.userInfo, let image = userInfo["image"] as? UIImage, let soundName = userInfo["soundName"] as? String {
                self.backgroundImageView.image = image
                guard let tabBar = self.tabBarController?.tabBar else { return }
                tabBar.alpha = 0.5
                switch soundName {
                case Background.rain.rawValue:
                    tabBar.backgroundColor = UIColor(hex: "#5A3B27")
                case Background.cafe.rawValue:
                    tabBar.backgroundColor = UIColor(hex: "#534835")
                case Background.forest.rawValue:
                    tabBar.backgroundColor = UIColor(hex: "#75665C")
                case Background.library.rawValue:
                    tabBar.backgroundColor = UIColor(hex: "#D3C4A0")
                    tabBar.alpha = 0.7
                case Background.ocean.rawValue:
                    tabBar.backgroundColor = UIColor(hex: "#5C5652")
                case Background.wind.rawValue:
                    tabBar.backgroundColor = UIColor(hex: "#34464A")
                default:
                    tabBar.tintColor = UIColor.lightGray
                }
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


