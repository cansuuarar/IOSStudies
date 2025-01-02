//
//  BackgroundViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 31.12.2024.
//

import UIKit

final class BackgroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()  // FlowLayout kullanıyoruz
        layout.scrollDirection = .vertical  // Scroll yönünü dikey yapıyoruz
        layout.minimumLineSpacing = 10 // Hücreler arasındaki dikey boşluk
        layout.minimumInteritemSpacing = 10 // Hücreler arasındaki yatay boşluk
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BackgroundCollectionViewCell.self, forCellWithReuseIdentifier: "collection")
        return cv
    }()
    
    private let titleLabel = UILabel()
    private let backgroundViewModel = BackgroundViewModel()
    private let okButton = UIButton()
    
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
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true
        
        view.addSubview(okButton)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = UIColor(hex: "#007AFF")
        okButton.layer.cornerRadius = 8
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
        // OK Butonu Kısıtlamaları
        okButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
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
        self.tabBarController?.selectedIndex = 0
    }
}

extension BackgroundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 2.5 // Her hücre için genişlik
        let heightPerItem = widthPerItem * 1.5 // Yükseklik genişliğin 1.5 katı (dikey dikdörtgen)
        return CGSize(width: widthPerItem , height: heightPerItem )
    }
}


extension Notification.Name {
    static let myNotification = Notification.Name("ChangeBackgrounImageNotification")
}
