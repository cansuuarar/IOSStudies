//
//  CurrencyListViewController.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import UIKit
import SwiftAlertView

final class CurrencyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    private var currency: Currency?
    private var filteredElements: [String: Double] = [:]
    private var selectedCurrency: [String: Double] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCurrencies(completionBlock: { currency in
            DispatchQueue.main.async {
                self.currency = currency
                self.dateLabel.text = currency.date
                // filteredElements değişkenine atama işlemini NetworkManager çağrısından sonra, yani API verisi geldikten sonra
                self.filteredElements = currency.typeCurrencies.filter { Constant.mainCurrencies.contains($0.key) }
                    //.map { (key: $0.key.uppercased(), value: $0.value) }
                    .reduce(into: [:]) { $0[$1.key.uppercased()] = $1.value }
                self.tableView.reloadData() // Data güncellendikten sonra tabloyu yeniliyoruz
                
            }
        })
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Constant.mainCurrencies.count
        filteredElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        let elementsArray = Array(filteredElements)
        let element = elementsArray[indexPath.row]
        cell.currencyName.text = element.key
        cell.currencyValue.text = String(format: "%.2f", element.value)
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurrency = Array(arrayLiteral: filteredElements)[indexPath.row]
        
    }
    
    
    
    
    @IBAction func favoriteCurrency(_ sender: Any) {
        /*do {
         let encoder = JSONEncoder()
         let data = try encoder.encode(currency)
         // UserDefaults
         UserDefaults.standard.set(data, forKey: "currency")
         let alert = UIAlertController(title: Constant.alertTitleSuccess, message: Constant.messageSuccessUserdefaults, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: Constant.buttonTitleOk, style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
         } catch {
         SwiftAlertView.show(title: Constant.alertTitle,
         message: Constant.messageFailedUserdefaults,
         buttonTitles: Constant.buttonTitleOk, Constant.buttonTitleCancel)
         }
         */
        UserDefaults.standard.set(selectedCurrency, forKey: "currency")
        let alert = UIAlertController(title: Constant.alertTitleSuccess, message: Constant.messageSuccessUserdefaults, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.buttonTitleOk, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func listFavoriteCurrencyButton(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "favList") as? ListFavoriteController else {return}
        navigationController?.pushViewController(vc, animated: true)
        
        /*
         guard let data = UserDefaults.standard.data(forKey: "currency") else { return }
         
         do {
         let decoder = JSONDecoder()
         let decodedCurrency = try decoder.decode(Currency.self, from: data)
         vc.currency = decodedCurrency
         } catch {
         SwiftAlertView.show(title: Constant.alertTitle,
         message: Constant.messageFailedDecode,
         buttonTitles: Constant.buttonTitleOk, Constant.buttonTitleCancel)
         }
         */
        
        guard let data = UserDefaults.standard.object(forKey: "currency") as? [String: Double] else { return }
        vc.typeCurrency = data
        
    }
}


