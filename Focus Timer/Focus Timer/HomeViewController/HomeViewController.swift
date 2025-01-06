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
    private var focusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.setupVideoBackground(for: self.view, videoName: .mountain)
        self.tabBarController?.tabBar.isHidden = true
        setupView()
        updateGreetingMessage()
        focusButton.addTarget(self, action: #selector(focusButtonStart), for: .touchUpInside)
    }
    
    private func setupView() {
        self.tabBarController?.tabBar.tintColor = UIColor(hex: "#B3B4AE")
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor( hex: "#D3C1A3")
        messageLabel = UILabel()
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate ([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        focusButton = UIButton()
        focusButton.setTitle("FOCUS", for: .normal)
        focusButton.tintColor = .white
        focusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(focusButton)
        
        NSLayoutConstraint.activate ([
            focusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            focusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func updateGreetingMessage() {
        let currentHour = Calendar.current.component(.hour, from: Date())
        var greetingMessage = ""
        
        if currentHour < 12 {
            greetingMessage = "Hi, Good Morning!"
        } else if currentHour >= 12 && currentHour < 18 {
            greetingMessage = "Hi, Good Afternoon!"
        } else {
            greetingMessage = "Hi, Good Evening!"
        }
        
        messageLabel.text = greetingMessage
    }
    
    @objc private func focusButtonStart() {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: view, duration: 0.2, options: transitionOptions, animations: {
            self.tabBarController?.selectedIndex = 1
        }, completion: nil)
        tabBarController?.tabBar.isHidden = false 
    }
    
    
}
