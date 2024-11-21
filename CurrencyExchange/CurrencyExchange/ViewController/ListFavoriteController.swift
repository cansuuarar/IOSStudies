//
//  ListFavoritesController.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 18.11.2024.
//

import UIKit

final class ListFavoriteController: UIViewController {

    @IBOutlet private weak var currencyNameLabel: UILabel!
    
    var currencyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyNameLabel.text = currencyName
        GradientHelper.applyGradient(to: view)
    }
}
