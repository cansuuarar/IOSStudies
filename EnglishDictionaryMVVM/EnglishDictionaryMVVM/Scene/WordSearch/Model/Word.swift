//
//  Dictionary.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import Foundation

struct Word: Codable {
    let word: String?
    //let phonetics: [Phonetic]?
    let meanings: [Meaning]?
}
