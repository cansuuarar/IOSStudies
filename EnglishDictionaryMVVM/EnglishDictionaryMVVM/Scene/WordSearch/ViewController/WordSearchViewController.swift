//
//  WordSearchViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import UIKit

final class WordSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WordSearchViewModelDelegate {
    
    @IBOutlet private weak var wordTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = WordSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.searchDelegate = self
    }
    
    
    func wordInfoLoaded() {
        tableView.reloadData()
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        guard let word = wordTextField.text, !word.isEmpty else { return }
        wordTextField.endEditing(true)
        viewModel.fetchWordMeaning(word: word)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        MeaningManager.shared.meanings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MeaningManager.shared.meanings[section].definitions?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        MeaningManager.shared.meanings[section].partOfSpeech?.uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: guard let ile yapılacak.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath) as? WordDefinitionCell else { return UITableViewCell()}
        let element =  MeaningManager.shared.meanings[indexPath.section].definitions?[indexPath.row].definition ?? "Oops, There is no definition provided."
        cell.definitionLabel.text = element
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDefinitionExample = MeaningManager.shared.meanings[indexPath.section].definitions?[indexPath.row].example
        guard let exampleVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "exampleVC") as? WordExampleViewController else { return }
        exampleVC.example = selectedDefinitionExample
        navigationController?.pushViewController(exampleVC, animated: true)
    }    
}
