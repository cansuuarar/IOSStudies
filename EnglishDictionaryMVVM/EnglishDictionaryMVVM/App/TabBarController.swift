//
//  ViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .myNotification, object: nil)
    }
    
    @objc func handleNotification(notification: Notification) {
        
        if let userInfo = notification.userInfo,
           let colorData = userInfo["color"] as? Data,
           let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
            
            guard let viewControllers = self.viewControllers, viewControllers.count > 0 else { return }
 
            guard let firstVC = self.viewControllers?[0] else { return }
            guard let navigationController = firstVC as? UINavigationController,
                  let firstViewController = navigationController.viewControllers[0] as? WordSearchViewController else { return firstVC.view.backgroundColor = color}
            firstViewController.view.backgroundColor = color
        }
        
 
       
        
    }
    
    // tab bar controller üzerinden mi yoksa view controller üzerinden mi erişmek gerek, araştır.
    // settingvc'den notification gönder, tab bar controllerda yakala ve change color apply et...
    
    // projeyi viper a çevir
    // projede bir de firebase entegrasyonu yap. firebase araştırıp analtik kısmını uygulamaya ekle, viper ya da mvvm projesine olabilir.
    // event ler.
    
}
