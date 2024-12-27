//
//  ViewController.swift
//  ToDoApp
//
//  Created by CANSU ARAR on 24.12.2024.
//

import UIKit

final class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        guard let rightBarButtonItem =  navigationItem.rightBarButtonItem else { return }
        rightBarButtonItem.tintColor = .white
        
        let newItem = Item()
        newItem.title = "Banana"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Apple"
        itemArray.append(newItem2)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
   
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
     
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK Add New Items
    
    @objc func addButton() {
        let alert = UIAlertController(title: "Add new to do item", message: "", preferredStyle: .alert)
        let newItem = Item()
        
        alert.addTextField() { (alertTextField) in
            alertTextField.placeholder = "Add new item"
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            guard let element = alert.textFields?[0].text else { return }
            newItem.title = element
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
      
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}

