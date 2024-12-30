//
//  CircularProgressBar.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 30.12.2024.
//

import UIKit

final class CircularProgressBar: UIView {
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        // Çizim için dairesel yol
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                        radius: (bounds.size.width - 8) / 2,
                                        startAngle: CGFloat(-CGFloat.pi / 2),
                                        endAngle: 3 * CGFloat.pi / 2,
                                        clockwise: true)
        
        // Arka plan (track) katmanı
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(hex: "#F1E1D1").cgColor
        trackLayer.lineWidth = 8
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        trackLayer.lineJoin = .round
        layer.addSublayer(trackLayer)
        
        // İlerleme (progress) katmanı
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor(hex: "#BFA6A0").cgColor
        progressLayer.lineWidth = 8
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineJoin = .round
        progressLayer.strokeEnd = 0 // Başlangıç noktası
        layer.addSublayer(progressLayer)
        
        self.backgroundColor = UIColor.clear
    }
    
    // İlerleme güncelleme fonksiyonu
    func setProgress(to progress: Float) {
        progressLayer.strokeEnd = CGFloat(progress)
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

