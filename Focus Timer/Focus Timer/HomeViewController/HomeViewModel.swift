//
//  HomeViewmodel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 3.01.2025.
//

import UIKit
import AVFoundation

protocol HomeViewModelDelegate {}

final class HomeViewModel {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    func setupVideoBackground(for view: UIView, videoName: Background) {
        guard let path = Bundle.main.path(forResource: videoName.rawValue, ofType: AudioExtension.videoMp4.rawValue) else { return }
        
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        // AVPlayerLayer ile video ekleniyor
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(playerLayer!, at: 0)
        
        // Video tekrar başlasın diye döngüye alıyoruz
        player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        // Video oynatılmaya başlıyor
        player?.play()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
}
