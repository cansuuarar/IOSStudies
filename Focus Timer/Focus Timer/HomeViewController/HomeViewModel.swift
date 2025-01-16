//
//  HomeViewmodel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 3.01.2025.
//

import UIKit
import AVFoundation

protocol HomeViewModelDelegate: AnyObject {
    //func videoReadyToPlay()
    func updateMessage(_ greetingMessage: String)
}

final class HomeViewModel: NSObject {
     var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    weak var homeDelegate: HomeViewModelDelegate?
    /*
    func setupVideoBackground(for view: UIView, videoName: Background, completion: @escaping () -> Void) {
        
        guard let path = Bundle.main.path(forResource: videoName.rawValue, ofType: AudioExtension.videoMp4.rawValue) else { return }
        let url = URL(fileURLWithPath: path)
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: self.player)
        
        //self.player?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
        
        self.playerLayer?.frame = view.bounds
        self.playerLayer?.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(self.playerLayer!, at: 0)
        view.alpha = 0.8
        self.player?.rate = 0.5
        self.player?.volume = 0.2
        self.player?.play()
        
        completion()
        
        self.player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if player?.status == .readyToPlay {
               //homeDelegate?.videoReadyToPlay()
                self.player?.rate = 0.5
                self.player?.volume = 0.2
                self.player?.play()
            } else if player?.status == .failed {
                print("Player failed: \(String(describing: player?.error))")
            }
        }
    }
     
    
    @objc private func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            player?.rate = 0.5
        }
    }
     */
    
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
    
    deinit {
        player?.removeObserver(self, forKeyPath: "status")
        NotificationCenter.default.removeObserver(self)
    }
}
