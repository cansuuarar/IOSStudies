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
    private var focusImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupView()
        homeViewModel.setupVideoBackground(for: self.view, videoName: .amazon)
        homeViewModel.homeDelegate = self
        homeViewModel.updateGreetingMessage()
        focusButton.addTarget(self, action: #selector(focusButtonStart), for: .touchUpInside)
    }
    
    private func setupView() {
        tabBarController?.tabBar.tintColor = UIColor(hex: "#B3B4AE")
        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.unselectedItemTintColor = UIColor( hex: "#D3C1A3")
        tabBarController?.viewControllers?.first?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        messageLabel = UILabel()
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate ([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        focusImageView = UIImageView()
        focusImageView.translatesAutoresizingMaskIntoConstraints = false
        focusImageView.image = UIImage(named: "circle.png")
        view.addSubview(focusImageView)
        
        NSLayoutConstraint.activate([
            focusImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            focusImageView.widthAnchor.constraint(equalTo: focusImageView.heightAnchor),
            focusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            focusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        focusImageView.layer.cornerRadius = focusImageView.frame.size.width / 2
        focusImageView.clipsToBounds = true
        
        focusButton = UIButton()
        focusButton.setTitle("FOCUS", for: .normal)
        focusButton.setTitleColor(.white, for: .normal)
        focusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        focusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(focusButton)
        
        NSLayoutConstraint.activate ([
            focusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            focusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
