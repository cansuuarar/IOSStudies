//
//  GradientHelper.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 20.11.2024.
//

import UIKit

class GradientHelper {
    
    private static let startColor = UIColor.blue
    private static let endColor = UIColor.green
    
    static func applyGradient(to view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,   // Başlangıç rengi
            UIColor.systemTeal.cgColor    // Bitiş rengi
        ]
        
        // Gradient'in yönünü ayarla (yukarıdan aşağıya)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)   // Üst orta
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)     // Alt orta
        
        // Layer'ı görünümün arka planına ekle
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
