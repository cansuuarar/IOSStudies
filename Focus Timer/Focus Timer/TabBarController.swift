//
//  TabBarController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 27.12.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = UIColor.cyan
    }
}

