//
//  BackgroundViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 31.12.2024.
//

import UIKit

final class BackgroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet private weak var collectionView: UICollectionView!
    private let titleLabel = UILabel()
    private let backgroundViewModel = BackgroundViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setView()
    }
    
    private func setView() {
        titleLabel.text = "Choose Background"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor(hex: "#BFA6A0")
        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftBarButton

        let layout = UICollectionViewFlowLayout()
                let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
                cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BackgroundCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BackgroundModel.backgroundData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as? BackgroundCollectionViewCell else { fatalError() }
        cell.label.text = BackgroundModel.backgroundData[indexPath.row].soundName
        cell.imageView.image = BackgroundModel.backgroundData[indexPath.row].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       SoundManager.shared.sound = BackgroundModel.backgroundData[indexPath.row].soundName
       guard let savedSound = SoundManager.shared.sound else { return }
       backgroundViewModel.playSound(name: savedSound)
    }
}



extension BackgroundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let availableWidth = collectionView.frame.width - (padding * 2) // 2 kenardan padding
        let widthPerItem = availableWidth / 3
        let heightPerItem = widthPerItem * 1.5
        return CGSize(width: widthPerItem , height: heightPerItem ) // 3:2 oranında dikdörtgen
        }
}
