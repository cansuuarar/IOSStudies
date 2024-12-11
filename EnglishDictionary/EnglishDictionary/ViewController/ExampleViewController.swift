//
//  ExampleViewController.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 2.12.2024.
//

import UIKit


final class ExampleViewController: UIViewController{
    @IBOutlet weak var exampleLabel: UILabel!
    var example: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleLabel.text = example
        
        exampleLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        exampleLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped() {
        guard let searchVC = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "searchVC") as? SearchViewController else { return }
       
        navigationController?.popViewController(animated: true)
    }
}


