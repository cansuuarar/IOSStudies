//
//  ViewController.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var wordTextField: UITextField! {
        didSet {
            wordTextField.setIcon(UIImage(imageLiteralResourceName: "search_icon"))
        }
    }
    @IBOutlet weak var callAPIButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var word: String?
    var meanings: [Meaning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPIButton.addTarget(self, action: #selector(getWord), for: .touchUpInside)
        wordTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func getWord() {
        guard let word = wordTextField.text, !word.isEmpty else { return }
        wordTextField.endEditing(true)
        
        NetworkManager.shared.getWordDefinitions(word: word, completionBlock: { apiResponseArray in
            DispatchQueue.main.async {
                for element in apiResponseArray {
                    if  element.word == word {
                        for meaning in element.meanings ?? [] {
                            self.meanings.append(meaning)
                        }
                    }

                }
                
            }})
        self.word = word
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meanings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath) as! DefinitionCell
                
        let element = meanings[indexPath.row]
        for definition in element.definitions ?? [] {
            cell.definitionLabel.text = definition.definition
        }

        return cell
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wordTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        wordTextField.text = ""
    }
}


extension UITextField {
    func setIcon(_ image: UIImage) {
        //size of icon
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
}
