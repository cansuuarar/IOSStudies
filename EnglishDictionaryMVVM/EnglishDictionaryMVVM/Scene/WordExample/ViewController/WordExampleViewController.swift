//
//  WordExampleViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 11.12.2024.
//

import UIKit

final class WordExampleViewController: UIViewController {

    @IBOutlet private weak var exampleLabel: UILabel!
    var example: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleLabel.text = example ?? "Oops, There is no example provided."
        
        exampleLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        exampleLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped() {
        guard UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "searchVC") is WordSearchViewController else { return }
        navigationController?.popViewController(animated: true)
    }



}
