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
    private var fullName = "Full Name: "
    private var familyName = "Family Name: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = fullName + (character?.fullName ?? "")
        familyLabel.text = familyName + (character?.family ?? "")
        imageView.sd_setImage(with: URL(string: character?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
}
