//
//  HomeViewmodel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 3.01.2025.
//

import UIKit
import AVFoundation

protocol HomeViewModelDelegate: AnyObject {
    func updateMessage(_ greetingMessage: String)
}

final class HomeViewModel: NSObject {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    weak var homeDelegate: HomeViewModelDelegate?
    
    func updateGreetingMessage()  {
        let currentHour = Calendar.current.component(.hour, from: Date())
        var greetingMessage = ""
        
        switch currentHour {
        case  0..<12:
            greetingMessage = Message.morning.rawValue
        case 12..<18:
            greetingMessage = Message.afternoon.rawValue
        case 18..<24:
            greetingMessage = Message.evening.rawValue
        default:
            greetingMessage = Message.defaultMessage.rawValue
        }
        
        homeDelegate?.updateMessage(greetingMessage)
    }
}
