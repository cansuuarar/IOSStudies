//
//  LaunchScreenViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 30.12.2024.
//

import UIKit

final class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.transitionToMainScreen()
        }
    }
    
    func transitionToMainScreen() {}
    



}
