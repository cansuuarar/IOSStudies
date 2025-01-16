//
//  HomeViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 3.01.2025.
//

import UIKit
import AVFoundation

final class HomeViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    private var messageLabel: UILabel!
    private var focusButton = UIButton()
    private var focusImageView: UIImageView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        guard let path = Bundle.main.path(forResource: "amazon", ofType: AudioExtension.videoMp4.rawValue) else { return }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        player?.automaticallyWaitsToMinimizeStalling = false
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(playerLayer!, at: 0)
        
        imageView = UIImageView(image: UIImage(named: "amazon_ss"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        view.layer.insertSublayer(imageView.layer, at: 1)
        
        view.alpha = 0.8
        player?.rate = 0.5
        player?.play()
        
        homeViewModel.homeDelegate = self
        setupVideoBackground(videoName: .amazon)
        setupView()
        homeViewModel.updateGreetingMessage()
    }
    
    func setupVideoBackground(videoName: Background) {
        self.player?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
        player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if player?.status == .readyToPlay {
                self.player?.rate = 0.5
                UIView.animate(withDuration: 1) {
                    self.imageView.alpha = 0
                } completion: {_ in 
                    self.imageView.removeFromSuperview()
                }

                self.player?.play()
            } else if player?.status == .failed {
                print("Player failed: \(String(describing: player?.error))")
            }
        }
    }
    
    @objc private func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            player?.rate = 0.5
        }
    }
    
    private func setupView() {
        self.tabBarItem = UITabBarItem(title: .none, image: UIImage(named: "home"), tag: 0)
        
        
        
        
       
        messageLabel = UILabel()
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        //messageLabel.text = message
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate ([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        focusImageView = UIImageView()
        focusImageView.translatesAutoresizingMaskIntoConstraints = false
        focusImageView.image = UIImage(named: "circle.png")
        focusImageView.layer.cornerRadius = focusImageView.frame.size.width / 2
        focusImageView.clipsToBounds = true
        containerView.addSubview(focusImageView)
        
        focusButton = UIButton()
        focusButton.translatesAutoresizingMaskIntoConstraints = false
        focusButton.setTitle("FOCUS", for: .normal)
        focusButton.setTitleColor(.white, for: .normal)
        focusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        focusButton.addTarget(self, action: #selector(self.focusButtonStart), for: .touchUpInside)
        containerView.addSubview(focusButton)
        
        NSLayoutConstraint.activate([
            focusImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            focusImageView.widthAnchor.constraint(equalTo: focusImageView.heightAnchor),
            focusImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            focusImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            focusButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            focusButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    @objc private func focusButtonStart() {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: view, duration: 0.2, options: transitionOptions, animations: {
            self.tabBarController?.selectedIndex = 1
        }, completion: nil)
        tabBarController?.tabBar.isHidden = false
    }
}

extension HomeViewController: HomeViewModelDelegate {
    /*func videoReadyToPlay() {
     DispatchQueue.main.async {
     self.setupView()
     }
     }
     */
    
    func updateMessage(_ greetingMessage: String) {
        messageLabel.text = greetingMessage
        //message = greetingMessage
    }
}
