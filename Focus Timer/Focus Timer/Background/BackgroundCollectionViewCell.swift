//
//  BackgroundCollectionViewCell.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 31.12.2024.
//

import UIKit

final class BackgroundCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    //cell storyboard üzerinden yüklendiği için bu metot ile ek ayarlar yapabiliriz.
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // taşan kısımları kırpar
    }
}
