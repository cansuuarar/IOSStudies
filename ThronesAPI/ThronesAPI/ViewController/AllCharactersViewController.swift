//
//  ViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 21.10.2024.
//

import UIKit
import SDWebImage

final class AllCharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    private var characterModelArray: [CharacterModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCharacters(completionBlock: { characterModelArray in
            DispatchQueue.main.async {
                self.characterModelArray = characterModelArray
                self.tableView.reloadData()
            }
        })
        
        // neden main.async:  getCharacter metodunda http isteği background processte çalışıyor olabilir. fakat bizim ui işlemimiz main queuda çalışır. bu sebeple main queue ya getirmiş oluyoruz.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullNameCell", for: indexPath) as! FullNameCell
        let element = characterModelArray[indexPath.row]
        
        cell.fullNameLabel.text = element.fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChar = characterModelArray[indexPath.row]
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "secondVC") as? CharacterViewController else {return}
        vc.character = selectedChar
        navigationController?.pushViewController(vc, animated: true)
    }
}

