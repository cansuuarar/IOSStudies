//
//  WordSearchPresenter.swift
//  EnglihsDictionaryVIPER
//
//  Created by CANSU ARAR on 25.12.2024.
//

import Foundation
// object
// protocol
// ref to interactor, router, view

protocol WordSearchPresenterProtocol {
    var router: WordSearchRouterProtocol? { get set}
    var interactor: WordSearchInteractorProtocol? { get set }
    var view: WordSearchViewControllerProtocol? { get set }
    
    func interactorDidFetchWords(with result: Result<[Word], Error>)
}

final class WordSearchPresenter: WordSearchPresenterProtocol {
    
    var router: WordSearchRouterProtocol?
    
    var interactor: WordSearchInteractorProtocol?
    
    var view: WordSearchViewControllerProtocol?
    
    func interactorDidFetchWords(with result: Result<[Word], any Error>) {
        
    }
    
    
    
}
