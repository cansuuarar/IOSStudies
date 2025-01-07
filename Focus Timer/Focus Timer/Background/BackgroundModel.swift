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
        BackgroundModel(soundName: "Rain", imageData: UIImage(named: "Rain")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Cafe", imageData: UIImage(named: "Cafe")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Forest", imageData: UIImage(named: "Forest")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Library", imageData: UIImage(named: "Library")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Ocean", imageData: UIImage(named: "Ocean")!.jpegData(compressionQuality: 1.0)!),
        BackgroundModel(soundName: "Wind", imageData: UIImage(named: "Wind")!.jpegData(compressionQuality: 1.0)!)
    ]
}

// UIImage decodable protokolüne uymaz. bu sebeple data tipinde ele alıp init ederken uiimage'e dönüştürülür.
// UIImage bir görselin kendisini bellekte temsil eder, ancak bu veriyi JSON formatında doğrudan kodlamayı veya kod çözmeyi desteklemez. JSON gibi veri formatları, genellikle görsel dosyasını ham veri (Data) veya dosya yolu (String) olarak temsil eder.
