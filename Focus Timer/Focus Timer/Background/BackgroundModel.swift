//
//  BackgroundModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 31.12.2024.
//

import UIKit

struct BackgroundModel: Codable {
    let soundName: String
    let imageData: Data
    
    var image: UIImage? {
        return UIImage(data: imageData)
    }
        
    static let backgroundData: [BackgroundModel] = [
        BackgroundModel(soundName: "Rain", imageData: UIImage(named: "rain")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Cafe", imageData: UIImage(named: "cafe")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Bird", imageData: UIImage(named: "forest")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Library", imageData: UIImage(named: "library2")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Ocean", imageData: UIImage(named: "ocean")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "wind", imageData: UIImage(named: "wind")!.jpegData(compressionQuality: 1.0)!)
    ]
}
