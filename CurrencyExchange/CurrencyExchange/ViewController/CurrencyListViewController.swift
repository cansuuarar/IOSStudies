//
//  CurrencyListViewController.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet private weak var tableView: UITableView!
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.getCurrencies(completionBlock: { currency in
            DispatchQueue.main.async {
                self.currency = currency
                self.tableView.reloadData()
            }
        })
       
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.mainCurrencies.count
    }
    
    func filterCurrencies(_ currency: [String: Double]) -> [String: Double] {
        currency.filter{ Constant.mainCurrencies.contains($0.key) }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell

        // Filtrelenmiş öğeleri alıyoruz
        let filteredElements = self.currency?.currencyType.filter{ Constant.mainCurrencies.contains($0.key) }

        // indexPath.row ile eşleşen öğeyi al
        if let element = filteredElements?.enumerated().first(where: { $0.offset == indexPath.row }) {
            let key = element.element.key
            let value = element.element.value
            
            // Anahtar ve değeri hücreye atama
            cell.currencyName.text = key
            cell.currencyValue.text = String(value)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
}


