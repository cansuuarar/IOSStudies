//
//  ViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 21.10.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data: String = ""
    var dataArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*NetworkManager.shared.getCharacter(id: 2, completionBlock: { dataArray in
            DispatchQueue.main.async {
                self.dataArray = dataArray
                self.tableView.reloadData()
            }
        })
         */
        NetworkManager.shared.getCharacters(completionBlock: { dataArray in
            DispatchQueue.main.async {
                self.dataArray = dataArray
                self.tableView.reloadData()
                
            }
        })
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.isScrollEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullNameCell", for: indexPath) as! FullNameCell
        let element = dataArray[indexPath.row]
        
        cell.fullNameLabel.text = element
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.fullName =
        }
    }
}

