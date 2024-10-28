//
//  MainPageViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 28.10.2024.
//

import UIKit
import SwiftAlertView

final class MainPageViewController: UIViewController {
    
    private var characterModelArray: [CharacterModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func listAllCharacters(_ sender: Any) {
        NetworkManager.shared.getCharacters(completionBlock: { characterModelArray in
            DispatchQueue.main.async {
                self.characterModelArray = characterModelArray
            }
        })
    }
    
    @IBAction func listFavoriteChars(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                                   .instantiateViewController(withIdentifier: "favoriteChars") as? FavoriteCharactersViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
        
        guard let data = UserDefaults.standard.data(forKey: "character") else {return}
        do {
            let decoder = JSONDecoder()
            let character = try decoder.decode(CharacterModel.self, from: data)
            vc.character = character
        } catch {
            SwiftAlertView.show(title: "ERROR",
                                message: "Failed to decode JSON",
                                buttonTitles: "OK", "Cancel")
            }
    }
   
}
