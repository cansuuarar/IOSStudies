//
//  DictionaryApiResponse.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 26.11.2024.
//

import Foundation

struct DictionaryApiResponse: Codable {
    let word: String?
    let phonetic: String?
    let phonetics: [Phonetic]?
    let origin: String?
    let meanings: [Meaning]?
    let license: License?
}
