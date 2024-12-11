//
//  WordSearchViewModel.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import Foundation

protocol WordSearchViewModelDelegate: AnyObject {
    func wordInfoLoaded()
}

class WordSearchViewModel {
    weak var searchDelegate: WordSearchViewModelDelegate?
    
    func fetchWordMeaning(word: String) {
        DictionaryNetworkManager.shared.getWordMeaning(word: word, completionBlock: { apiResponseArray in
            DispatchQueue.main.async {
                MeaningManager.shared.meanings.removeAll()
                // TODO: high order function
                for element in apiResponseArray {
                    if  element.word == word {
                        for meaning in element.meanings ?? [] {
                            MeaningManager.shared.meanings.append(meaning)
                        }
                    }
                }
                self.searchDelegate?.wordInfoLoaded()
            }
        }
        )
    }
}
