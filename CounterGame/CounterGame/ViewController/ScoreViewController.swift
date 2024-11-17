//
//  TapViewController.swift
//  CounterGame
//
//  Created by CANSU ARAR on 31.10.2024.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var score = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scoreLabel.text = String(score)
       
        //default 0
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        
        if score >= highScore {
            UserDefaults.standard.set(score, forKey: "highScore")
            highScoreLabel.text = String(score)
        } else {
            highScoreLabel.text = String(highScore)
        }
   
    }
    
}

