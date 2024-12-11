//
//  ViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import UIKit

class TabBarController: UITabBarController, SettingsColorChangeDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [WordSearchViewController(), SettingsViewController()]
        
    }
    
    func changeColor(color: UIColor) {
        //tabBarController?.viewControllers?[0].view.backgroundColor = color
    }
    
}

