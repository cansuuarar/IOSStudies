//
//  ViewController.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import UIKit
import AVFoundation

final class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsControllerColorDelegate {
    
    @IBOutlet private weak var wordTextField: UITextField! {
        didSet {
            wordTextField.setIcon(UIImage(imageLiteralResourceName: "search_icon"))
        }
    }
    @IBOutlet private weak var callAPIButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var word: String?
    private var meanings: [Meaning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPIButton.addTarget(self, action: #selector(getWord), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func getWord(_ sender: UIButton) {
        guard let word = wordTextField.text, !word.isEmpty else { return }
        wordTextField.endEditing(true)
        self.word = word
        
        NetworkManager.shared.getWordDefinitions(word: word, completionBlock: { apiResponseArray in
            DispatchQueue.main.async {
                self.meanings.removeAll()
                for element in apiResponseArray {
                    if  element.word == word {
                        for meaning in element.meanings ?? [] {
                            self.meanings.append(meaning)
                        }
                    }
                }
                // high order functions
                self.tableView.reloadData()
            }})
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        meanings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meanings[section].definitions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: guard let ile yapılacak.
        let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath) as! DefinitionCell
        let element = meanings[indexPath.section].definitions?[indexPath.row].definition ?? "Oops, There is no definition provided."
        cell.definitionLabel.text = element
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        meanings[section].partOfSpeech?.uppercased()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDefinitionExample = meanings[indexPath.section].definitions?[indexPath.row].example
        guard let exampleVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "exampleVC") as? ExampleViewController else { return }
        exampleVC.example = selectedDefinitionExample
        navigationController?.pushViewController(exampleVC, animated: true) //navigation stack e yeni vc eklenir ve bu vcye yönlendirilir.
    }
    
    @IBAction func audioButtonPressed(_ sender: Any) {
    }
    
    @IBAction private func settingsButtonPressed(_ sender: Any) {
        guard let appVC = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "settingsVC") as? SettingsViewController else { return }
        appVC.colorDelegate = self
        navigationController?.pushViewController(appVC, animated: true)
    }
    
    func applyColor(color: UIColor) {
        view.backgroundColor = color
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
}

// coordinator

// utilies folder --> extensions 'lar yazılır.
