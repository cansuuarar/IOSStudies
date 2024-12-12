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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath) as? WordDefinitionCell else { return UITableViewCell()}
        let element =  MeaningManager.shared.meanings[indexPath.section].definitions?[indexPath.row].definition ?? "Oops, There is no definition provided."
        cell.definitionLabel.text = element
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDefinitionExample = MeaningManager.shared.meanings[indexPath.section].definitions?[indexPath.row].example ?? "Oops, There is no example provided."
        guard let exampleVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "exampleVC") as? WordExampleViewController else { return }
        //exampleVC.wordExampleViewModel.setExample(example: selectedDefinitionExample)
        //let wordExampleViewModel = WordExampleViewModel()
        //exampleVC.setVM(wordExampleViewModel: wordExampleViewModel)
        //wordExampleViewModel.setExample(example: selectedDefinitionExample)
        
        var wordExampleVM = WordExampleViewModel(example: selectedDefinitionExample)
        exampleVC.setVM(wordExampleViewModel: wordExampleVM)
        
        navigationController?.pushViewController(exampleVC, animated: true)
    }    
}


