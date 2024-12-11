//
//  MeaningManager.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import Foundation

final class MeaningManager {
    static let shared = MeaningManager()
    var meanings: [Meaning] = []
    
    private init() {}
}
