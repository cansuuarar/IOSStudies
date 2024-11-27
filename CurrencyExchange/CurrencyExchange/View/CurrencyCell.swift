//
//  CurrencyCell.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import UIKit
import SwiftAlertView

protocol CurrencyCellDelegate: AnyObject {
    func favoriteSelected(selectedCurrency: CurrencyModel)
}

final class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var currencyModel: CurrencyModel?
    weak var currencyCellDelegate: CurrencyCellDelegate?
    
    @IBAction private func favoriteButtonPressed(_ sender: Any) {
        currencyCellDelegate?.favoriteSelected(selectedCurrency: currencyModel!)
    }
}

//awake from nib

//anyobject bak
