//
//  Definition.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import Foundation

struct Definition: Codable  {
    let definition: String?
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
}
