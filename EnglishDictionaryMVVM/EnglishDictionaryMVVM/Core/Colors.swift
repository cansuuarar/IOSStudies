//
//  Colors.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 11.12.2024.
//

import UIKit

enum Colors: String, CaseIterable {
    case red = "red"
    case green = "green"
    case blue = "blue"
    case yellow = "yellow"
    case black = "black"
    case white = "white"
    case gray = "gray"
    
    var uiColor: UIColor {
            switch self {
            case .red:
                return .red
            case .blue:
                return .blue
            case .green:
                return .green
            case .yellow:
                return .yellow
            case .black:
                return .black
            case .white:
                return .white
            case .gray:
                return .gray
            }
        }
}
