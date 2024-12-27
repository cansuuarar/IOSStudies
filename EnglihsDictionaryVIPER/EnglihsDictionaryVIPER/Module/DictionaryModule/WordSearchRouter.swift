//
//  WordSearchRouter.swift
//  EnglihsDictionaryVIPER
//
//  Created by CANSU ARAR on 25.12.2024.
//


import UIKit
// object
// entry point

protocol WordSearchRouterProtocol: AnyObject {
    
}

final class WordSearchRouter: WordSearchRouterProtocol {
    
   weak var view: WordSearchViewController!
    
    static func start() -> UIViewController {
        let router = WordSearchRouter()
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WordSearchViewController") as! WordSearchViewController
        let presenter = WordSearchPresenter()
        let interactor = WordSearchInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
    
    
  
}
