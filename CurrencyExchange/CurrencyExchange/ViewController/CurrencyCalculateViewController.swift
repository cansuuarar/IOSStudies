//
//  CurrencyCalculateViewController.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import UIKit

class CurrencyCalculateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var amountEnteredTextField: UITextField!
    @IBOutlet weak var baseCurrency: UILabel!
    @IBOutlet weak var targetCurrencyPickerView: UIPickerView!
    @IBOutlet weak var resultAmount: UITextField!
    
    private var currency: Currency?
    private var calculatedAmount: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCurrencies(completionBlock: { currency in
            DispatchQueue.main.async {
                self.currency = currency
                self.baseCurrency.text = Currency.CodingKeys.typeCurrencies.rawValue.uppercased()
            }
        })
       
        
        GradientHelper.applyGradient(to: view)
        
        targetCurrencyPickerView.delegate = self
        targetCurrencyPickerView.dataSource = self
        amountEnteredTextField.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        amountEnteredTextField.addTarget(self, action: #selector(calculateTargetCurrency), for: .editingDidEnd)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Constant.mainCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Constant.mainCurrencies[row].uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        calculateTargetCurrency()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountEnteredTextField {
            let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: ",."))
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return false
    }
    
    @objc func calculateTargetCurrency() {
        guard let inputText = amountEnteredTextField.text, let enteredAmount = Double(inputText) else { return }
        let selectedIndex = targetCurrencyPickerView.selectedRow(inComponent: 0)
        let selectedCurrencyName = Constant.mainCurrencies[selectedIndex]
        
        guard let currency = currency?.typeCurrencies.keys.first(where: { $0 == selectedCurrencyName }) else { return }
        let value = self.currency?.typeCurrencies[currency]
        
        resultAmount.text = String(format: "%.2f", (enteredAmount * (value ?? 0.0)))
    }
}
