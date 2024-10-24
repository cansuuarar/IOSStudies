//
//  SecondViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 22.10.2024.
//

import UIKit
import SDWebImage

class SecondViewController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var fullName: String?
    let labelName = "Full Name: "
    var family: String?
    let labelFamily = "Family: "
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = labelName + (fullName ?? "")
        familyLabel.text = labelFamily + (family ?? "")
        imageView.sd_setImage(with: URL(string: imageUrl!), placeholderImage: UIImage(named: "placeholder"))
    }
    
}
