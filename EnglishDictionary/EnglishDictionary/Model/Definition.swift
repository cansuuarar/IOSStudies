//
//  Definition.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import Foundation

struct Definition: Codable  {
    var definition: String?
    var example: String?
    var synonyms: [String]?
    var antonyms: [String]?
}
