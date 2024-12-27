//
//  WordSearchViewController.swift
//  EnglihsDictionaryVIPER
//
//  Created by CANSU ARAR on 25.12.2024.
//

import UIKit
// view controller
// protocol
// ref to presenter

protocol WordSearchViewControllerProtocol: AnyObject {
    var presenter: WordSearchPresenterProtocol? { get set }
    
    func updateView()
    func getWordDefinition() -> [String]
}

final class WordSearchViewController: UIViewController, WordSearchViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: WordSearchPresenterProtocol?
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var wordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func updateView() {
        
    }
    
    func getWordDefinition() -> [String] {
        return ["adasd"]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
}
