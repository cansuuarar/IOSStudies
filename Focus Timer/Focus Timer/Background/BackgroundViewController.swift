//
//  BackgroundViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 31.12.2024.
//

import UIKit

final class BackgroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var collectionView: UICollectionView!
    private let titleLabel = UILabel()
    private let okButton = UIButton()
    private let backgroundViewModel = BackgroundViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        collectionView.delegate = self
        collectionView.dataSource = self
        applyGradientBackground()
    }
    
    private func setView() {
        tabBarController?.tabBarItem.image = UIImage(named: "home.png")
        titleLabel.text = "Set Your Space"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor(hex: "#BFA6A0")
        //let leftBarButton = UIBarButtonItem(customView: titleLabel)
        //navigationItem.leftBarButtonItem = leftBarButton
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // Genişlik
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
        let layout = UICollectionViewFlowLayout()
        // horizontal
        //layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10 // Hücreler arasındaki dikey boşluk
        layout.minimumInteritemSpacing = 5 // Hücreler arasındaki yatay boşluk
        //let itemWidth = (self.view.frame.width - 48) / 3 // 48: iki boşluk (16 * 3)
        
        // vertical
        layout.scrollDirection = .vertical
        let itemWidth = (self.view.frame.width - 48) / 2
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BackgroundCollectionViewCell.self, forCellWithReuseIdentifier: "collection")
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        view.addSubview(okButton)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("Set", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = UIColor(hex: "#B3B4AE")
        okButton.layer.cornerRadius = 8
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
        okButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BackgroundModel.backgroundData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as? BackgroundCollectionViewCell else { fatalError() }
        cell.imageView.image = BackgroundModel.backgroundData[indexPath.item].image
        cell.label.text = BackgroundModel.backgroundData[indexPath.item].soundName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        BackgroundManager.shared.backgroundModel = BackgroundModel.backgroundData[indexPath.item]
        guard let backgroundModel = BackgroundManager.shared.backgroundModel else { return }
        let backgrounModel = BackgroundModel(soundName: backgroundModel.soundName, imageData:  backgroundModel.image!.jpegData(compressionQuality: 1.0)!)
        
        backgroundViewModel.playSound(name: backgrounModel.soundName)
    }
    
    @objc func okButtonTapped() {
        guard let savedBackground =  BackgroundManager.shared.backgroundModel else { return }
        backgroundViewModel.saveToUserdefaults(backgroundModel: savedBackground)
        backgroundViewModel.stopSound()
        guard let image = savedBackground.image else { return }
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: ["image": image])
        }
        //self.tabBarController?.selectedIndex = 1
        self.dismiss(animated: true)
    }
    
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(hex: "#f0f4f8").cgColor,
            UIColor(hex: "#d6d2cf").cgColor,
            UIColor(hex: "#e0dedb").cgColor,
            UIColor(hex: "#dad8d1").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension BackgroundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 2.5 // Her hücre için genişlik
        let heightPerItem = widthPerItem * 1.5 // dikdörtgen
        return CGSize(width: widthPerItem , height: heightPerItem )
    }
}

extension Notification.Name {
    static let myNotification = Notification.Name("ChangeBackgrounImageNotification")
}
