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
    @IBOutlet private weak var lastUpdateDateLabel: UILabel!
    
    private var filteredElements: [CurrencyModel] = []
    private var selectedElement: CurrencyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCurrencies(completionBlock: { currency in
            DispatchQueue.main.async {
                
                self.lastUpdateDateLabel.text = "Last update date: " + currency.date
                // filteredElements değişkenine atama işlemini NetworkManager çağrısından sonra, yani API verisi geldikten sonra
                
                for element in currency.typeCurrencies.filter({ Constant.mainCurrencies.contains($0.key) }) {
                    let currencyModel = CurrencyModel()
                    currencyModel.currencyName = element.key
                    currencyModel.currencyValue = element.value
                    self.filteredElements.append(currencyModel)
                }
                
                self.tableView.reloadData() // Data güncellendikten sonra tabloyu yeniliyoruz
            }
        })
        
        GradientHelper.applyGradient(to: view)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        
        GradientHelper.applyGradient(to: cell.contentView)
        
        let element = filteredElements[indexPath.row]
        cell.currencyName.text = element.currencyName
        cell.currencyValue.text = String(format: "%.2f", element.currencyValue ?? 0)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedElement = filteredElements[indexPath.row]
    }
    
    @IBAction private func favoriteCurrency(_ sender: Any) {
        
        var favCurrency = UserDefaults.standard.string(forKey: "currency")
        if favCurrency != selectedElement?.currencyName {
            UserDefaults.standard.set(selectedElement?.currencyName, forKey: "currency")

        }
    
        if let data = UserDefaults.standard.string(forKey: "currency"), !data.isEmpty  {
            let alert = UIAlertController(title: Constant.alertTitleSuccess, message: Constant.messageSuccessUserdefaults, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constant.buttonTitleOk, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: Constant.alertTitleError, message: Constant.messageFailedUserdefaults, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constant.buttonTitleOk, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction private func listFavoriteCurrencyButton(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "favList") as? ListFavoriteController else {return}
        navigationController?.pushViewController(vc, animated: true)
        
        guard let data = UserDefaults.standard.string(forKey: "currency") else { return }
        
        vc.currencyName = data
    }
}


