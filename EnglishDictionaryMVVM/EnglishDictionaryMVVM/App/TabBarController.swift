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
        
        //let tabBarController = UITabBarController()
        //tabBarController.viewControllers = [WordSearchViewController(), SettingsViewController()]
        
    }
    
    func changeColor(color: UIColor) {
        //self.viewControllers?[0].view.backgroundColor = color
        // tab bar controller üzerinden mi yoksa view controller üzerinden mi erişmek gerek, araştır.
        //
    }
    
}


// settingvc'den notification gönder, tab bar controllerda yakala ve change color apply et...
