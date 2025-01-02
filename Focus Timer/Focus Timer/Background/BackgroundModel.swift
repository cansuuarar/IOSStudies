//
//  BackgroundModel.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 31.12.2024.
//

import UIKit

struct BackgroundModel {
    let soundName: String
    let image: UIImage
   

    static let backgroundData: [BackgroundModel] = [
        BackgroundModel(soundName: "Rain", image: UIImage(named: "rain")!),
        BackgroundModel(soundName: "Cafe", image: UIImage(named: "cafe")!)
    ]

}
