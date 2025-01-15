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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        homeViewModel.setupVideoBackground(for: self.view, videoName: .amazon) {
            DispatchQueue.main.async {
                self.setupView()
                self.homeViewModel.homeDelegate = self
                self.homeViewModel.updateGreetingMessage()
            }
        }
    }

    private func setupView() {
        self.tabBarItem = UITabBarItem(title: .none, image: UIImage(named: "home"), tag: 0)
        messageLabel = UILabel()
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
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
    func updateMessage(_ greetingMessage: String) {
        messageLabel.text = greetingMessage
    }
}
