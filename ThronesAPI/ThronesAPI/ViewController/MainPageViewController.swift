//
//  MainPageViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 28.10.2024.
//

import UIKit
import SwiftAlertView
import Security

final class MainPageViewController: UIViewController {
    
    private var characterModelArray: [CharacterModel] = []
    /*
     sadece super call olduğu için yazmamıza gerek yok.
     override func viewDidLoad() {
     super.viewDidLoad()
     }
     */
    
    @IBAction private func listAllCharacters(_ sender: Any) {
        NetworkManager.shared.getCharacters(completionBlock: { characterModelArray in
            DispatchQueue.main.async {
                self.characterModelArray = characterModelArray
            }
        })
    }
    
    @IBAction private func listFavoriteChars(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "favoriteChars") as? FavoriteCharactersViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
        
        guard let data = UserDefaults.standard.data(forKey: "character") else {return}
        do {
            let decoder = JSONDecoder()
            let character = try decoder.decode(CharacterModel.self, from: data)
            vc.character = character
        } catch {
            SwiftAlertView.show(title: Constant.alertTitle,
                                message: Constant.messageFailedDecode,
                                buttonTitles: Constant.buttonTitleOk, Constant.buttonTitleCancel)
        }
    }
    
    
    @IBAction private func keyChainFavs(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "favoriteChars") as? FavoriteCharactersViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "favoriteCharacter",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let data = result as? Data {
            do {
                let decoder = JSONDecoder()
                let character = try decoder.decode(CharacterModel.self, from: data)
                vc.character = character
            } catch {
                SwiftAlertView.show(title: Constant.alertTitle,
                                    message: Constant.messageFailedDecode,
                                    buttonTitles: Constant.buttonTitleOk, Constant.buttonTitleCancel)
            }
        } else {
            SwiftAlertView.show(title: Constant.alertTitle,
                                message: Constant.messageKeychain,
                                buttonTitles: Constant.buttonTitleOk, Constant.buttonTitleCancel)
        }
    }
}
