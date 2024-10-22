//
//  ViewController.swift
//  APIExample
//
//  Created by CANSU ARAR on 17.10.2024.
//

import UIKit
import Alamofire
import SwiftAlertView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getFacts(count: 3, completionBlock: {dataArray in
            DispatchQueue.main.async {
               // self.factLabel.text = dataArray.joined()
                self.dataArray = dataArray
                self.tableView.reloadData()
            }
        })
        tableView.delegate = self
        tableView.dataSource = self
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
}

