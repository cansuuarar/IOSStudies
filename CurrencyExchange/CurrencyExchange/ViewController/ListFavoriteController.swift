//
//  ListFavoritesController.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 18.11.2024.
//

import UIKit

class ListFavoriteController: UIViewController {

    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var typeCurrency: [String: Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyNameLabel.text = typeCurrency?.keys.first
    }
    
}
