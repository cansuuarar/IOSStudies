//
//  ViewController.swift
//  CounterGame
//
//  Created by CANSU ARAR on 31.10.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 8.0
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            containerView.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet private weak var startStopButton: UIButton! {
        didSet {
            startStopButton.layer.cornerRadius = 8.0
        }
    }
    
    @IBOutlet private weak var counterLabel: UILabel! {
        didSet {
            counterLabel.textColor = UIColor.darkGreen
            counterLabel.text = String(timerValue)
        }
    }
    
    private var timer =  Timer()
    private var timerValue = AppConstant.TIMER_SECOND
    private var tapCount = 0
    private var isGameStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.resetStandardUserDefaults()
    }
    
    
    @IBAction private func startStopButtonPressed(_ sender: Any) {
        if !isGameStarted {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            isGameStarted = true
        }
    }
    
    @objc private func handleTap() {
        if isGameStarted {
            tapCount += 1
            startStopButton.setTitle(String(tapCount), for: .normal)
        }
    }
    
    @objc private func fireTimer() {
        timerValue -= 1
        if timerValue <= 0 {
            timer.invalidate()
            isGameStarted = false
            guard let scoreVC = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                .instantiateViewController(withIdentifier: "scoreVC") as? ScoreViewController else {return}
            scoreVC.score = tapCount
            navigationController?.pushViewController(scoreVC, animated: true)
            
            tapCount = 0
            timerValue = AppConstant.TIMER_SECOND
            startStopButton.setTitle("start", for:.normal )
        }
        counterLabel.text = String(timerValue)
    }
}
    




