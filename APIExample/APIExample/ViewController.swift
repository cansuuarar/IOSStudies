//
//  ViewController.swift
//  APIExample
//
//  Created by CANSU ARAR on 17.10.2024.
//

import UIKit
import Alamofire
import SwiftAlertView
import Security

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var getFavorite: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [String] = []
    var selectedFact: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        tableView.delegate = self
        tableView.dataSource = self
        getFavorite.isHidden = true
        let notSortedArray = [3, 10, 5, 1, 8 ,12]
        let sortedArray = notSortedArray.sorted()
        print(sortedArray)
    }
    
    func refresh() {
        NetworkManager.shared.getFacts(count: 2, completionBlock: {dataArray in
            DispatchQueue.main.async {
               // self.factLabel.text = dataArray.joined()
                self.dataArray = dataArray
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! ApiCell
        let element = dataArray[indexPath.row]
        
        cell.label1.text = element
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFact = dataArray[indexPath.row]
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        UserDefaults.standard.set(selectedFact, forKey: "fact")
        
            print("set" + selectedFact)
    }
    
    @IBAction func getFavorite(_ sender: Any) {
        let favFact = UserDefaults.standard.string(forKey: "fact")
        getFavorite.text = favFact
        getFavorite.isHidden = false
        print("get" + favFact!)
    }
    
}

