//
//  MeaningManager.swift
//  EnglihsDictionaryVIPER
//
//  Created by CANSU ARAR on 25.12.2024.
//

import Foundation

final class MeaningManager {
    static let shared = MeaningManager()
    var meanings: [Meaning] = []
    
    private init() {}
}
