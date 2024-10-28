//
//  FavoriteCharactersViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 28.10.2024.
//

import UIKit

final class FavoriteCharactersViewController: UIViewController {

    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var familyLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = character?.fullName ?? ""
        familyLabel.text = character?.family ?? ""
        imageView.sd_setImage(with: URL(string: character?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
    

}
