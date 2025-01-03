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
        BackgroundModel(soundName: "Cafe", imageData: UIImage(named: "cafe2")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Forest2", imageData: UIImage(named: "forest")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Classroom", imageData: UIImage(named: "classroom")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Ocean", imageData: UIImage(named: "ocean2")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Wind", imageData: UIImage(named: "windy")!.jpegData(compressionQuality: 1.0)!)
    ]
}
