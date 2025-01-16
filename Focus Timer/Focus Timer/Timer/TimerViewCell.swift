//
//  TimerViewCell.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 15.01.2025.
//

import UIKit

final class TimerViewCell: UIView {
    var backgroundButton = UIButton()
    var decreaseButton = UIButton()
    var increasebutton = UIButton()
    var timerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
