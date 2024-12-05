//
//  Meaning.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import Foundation

struct Meaning : Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    let synonyms: [String]?
    let antonyms: [String]?
}


