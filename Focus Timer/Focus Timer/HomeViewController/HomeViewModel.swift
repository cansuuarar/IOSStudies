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

final class HomeViewModel {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    weak var homeDelegate: HomeViewModelDelegate?
    
    func setupVideoBackground(for view: UIView, videoName: Background) {
        guard let path = Bundle.main.path(forResource: videoName.rawValue, ofType: AudioExtension.videoMp4.rawValue) else { return }
        view.alpha = 0.8
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(playerLayer!, at: 0)
        
        player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        player?.play()
        player?.rate = 0.5
        player?.volume = 0.2
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)

        }
    }
    
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
