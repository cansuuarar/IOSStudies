//
//  WordSearchInteractor.swift
//  EnglihsDictionaryVIPER
//
//  Created by CANSU ARAR on 25.12.2024.
//

import Foundation
// object
// protocol
// ref to presenter

protocol WordSearchInteractorProtocol {
    var presenter: WordSearchPresenterProtocol? { get set }
    
    func getWordMeaning(word: String)
}

protocol WordSearchInteractorDelegate: AnyObject {
    func wordInfoLoaded()
}

final class WordSearchInteractor: WordSearchInteractorProtocol {
    var presenter: WordSearchPresenterProtocol?
    weak var searchDelegate: WordSearchInteractorDelegate?
    
    func getWordMeaning(word: String) {
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
