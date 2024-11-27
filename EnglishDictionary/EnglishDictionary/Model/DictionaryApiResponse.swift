//
//  DictionaryApiResponse.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 26.11.2024.
//

import Foundation

struct DictionaryApiResponse: Codable {
    var word: String?
    var phonetic: String?
    var phonetics: [Phonetic]?
    var origin: String?
    var meanings: [Meaning]?
    let license: License?
}
