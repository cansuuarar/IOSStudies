//
//  Meaning.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import Foundation

struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    let synonyms: [String]?
    let antonyms: [String]?
}
