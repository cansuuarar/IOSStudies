//
//  SecondViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 22.10.2024.
//

import UIKit
import SDWebImage
import SwiftAlertView


final class CharacterViewController: UIViewController {

    @IBOutlet weak private var fullNameLabel: UILabel!
    @IBOutlet weak private var familyLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    
    var character: CharacterModel?
    private let labelName = "Full Name: "
    private let labelFamily = "Family: "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = labelName + (character?.fullName ?? "")
        familyLabel.text = labelFamily + (character?.family ?? "")
        imageView.sd_setImage(with: URL(string: character?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func favoriteCharacter(_ sender: Any) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(character)
            UserDefaults.standard.set(data, forKey: "character")
            let alert = UIAlertController(title: "Success", message: "Character saved successfuly!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

           /* SwiftAlertView.show(title: "SUCCESS",
                                message: "Character saved successfuly",
                                buttonTitles: "OK")
            */
        } catch {
            SwiftAlertView.show(title: "ERROR", 
                                message: "Failed to save character",
                                buttonTitles: "OK", "Cancel")
        }
    }
}
