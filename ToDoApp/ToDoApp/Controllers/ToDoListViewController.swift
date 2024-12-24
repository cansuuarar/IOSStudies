//
//  ViewController.swift
//  ToDoApp
//
//  Created by CANSU ARAR on 24.12.2024.
//

import UIKit

final class ToDoListViewController: UITableViewController {

    private var itemArray = ["Banana", "Apple"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        guard let rightBarButtonItem =  navigationItem.rightBarButtonItem else { return }
        rightBarButtonItem.tintColor = .white
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
       
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK Add New Items
    
    @objc func addButton() {
        let alert = UIAlertController(title: "Add new to do item", message: "", preferredStyle: .alert)
        alert.addTextField() { (alertTextField) in
            alertTextField.placeholder = "Add new item"
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            guard let element = alert.textFields?[0].text else { return }
            self.itemArray.append(element)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
      
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}

