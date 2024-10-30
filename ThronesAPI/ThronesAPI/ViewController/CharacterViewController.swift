//
//  SecondViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 22.10.2024.
//

import UIKit
import SDWebImage
import SwiftAlertView
import Security

final class CharacterViewController: UIViewController {
    
    @IBOutlet weak private var fullNameLabel: UILabel!
    @IBOutlet weak private var familyLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    
    var character: CharacterModel?
    private var fullName = "Full Name: "
    private var familyName = "Family Name: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = fullName + (character?.fullName ?? "")
        familyLabel.text = familyName + (character?.family ?? "")
        imageView.sd_setImage(with: URL(string: character?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func favoriteCharacter(_ sender: Any) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(character)
            // UserDefaults
            UserDefaults.standard.set(data, forKey: "character")
            let alert = UIAlertController(title: "Success", message: "Character saved successfuly!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } catch {
            SwiftAlertView.show(title: "ERROR",
                                message: "Failed to save character",
                                buttonTitles: "OK", "Cancel")
        }
    }
    
    // keychain
    @IBAction func saveToKeyChain(_ sender: Any) {
        clearKeychain()
        do {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(character) {
                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: character?.fullName ?? "",
                    kSecAttrService as String: "favoriteCharacter",
                    kSecValueData as String: data
                ]
                
                SecItemDelete(query as CFDictionary)
                SecItemAdd(query as CFDictionary, nil)
                let alert = UIAlertController(title: "Success", message: "Character saved successfuly!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func clearKeychain() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("keychain items deleted")
        } else {
            print("error: \(status)")
        }
    }
}
