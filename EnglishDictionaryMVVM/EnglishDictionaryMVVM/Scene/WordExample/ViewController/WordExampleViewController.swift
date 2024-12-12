//
//  WordExampleViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 11.12.2024.
//

import UIKit

final class WordExampleViewController: UIViewController {

    @IBOutlet private weak var exampleLabel: UILabel!
    private var wordExampleViewModel = WordExampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleLabel.text = wordExampleViewModel.getExample()
        //exampleLabel.text = example ?? "Oops, There is no example provided."
        
        exampleLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        exampleLabel.addGestureRecognizer(tapGesture)
    }
    
    func setVM(wordExampleViewModel: WordExampleViewModel) {
        self.wordExampleViewModel = wordExampleViewModel
    }
    
    @objc func labelTapped() {
        guard UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "searchVC") is WordSearchViewController else { return }
        navigationController?.popViewController(animated: true)
    }



}
