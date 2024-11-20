//
//  CurrencyCalculateViewController.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import UIKit

class CurrencyCalculateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // to do: text field e non char girilmesine izin verilmeyecek.
    @IBOutlet weak var amountEnteredTextField: UITextField!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var baseCurrency: UILabel!
    @IBOutlet weak var targetCurrencyPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetCurrencyPickerView.delegate = self
        targetCurrencyPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Constant.mainCurrencies.count
    }
    
    //her satırda gösterilecek metni belirler, delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Constant.mainCurrencies[row].uppercased()
    }

   

}
