//
//  RootRouter.swift
//  EnglihsDictionaryVIPER
//
//  Created by CANSU ARAR on 25.12.2024.
//

import UIKit

class RootRouter {
    
    func presentWordScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = WordSearchRouter.start()
    }
}
