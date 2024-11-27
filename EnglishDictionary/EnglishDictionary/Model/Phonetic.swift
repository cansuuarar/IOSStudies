//
//  Phonetic.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import Foundation

struct Phonetic: Codable  {
    var text: String?
    var audio: String?
    let license: License?
}
