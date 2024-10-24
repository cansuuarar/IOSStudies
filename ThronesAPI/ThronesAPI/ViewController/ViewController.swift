//
//  ViewController.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 21.10.2024.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var characterModelArray: [CharacterModel] = []
    var selectedChar: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCharacter(completionBlock: { characterModelArray in
            DispatchQueue.main.async {
                self.characterModelArray = characterModelArray
                self.tableView.reloadData()
            }
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.allowsSelection = true
        //tableView.isScrollEnabled = true
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
        selectedChar = characterModelArray[indexPath.row]
        performSegue(withIdentifier: "toSecondVC", sender: self) //segue manuel tetikleme
        //storyboardda segue yi view controllerdan secondVC ye bağladım.
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.fullName = selectedChar?.fullName
            destinationVC.family = selectedChar?.family
            destinationVC.imageUrl = selectedChar?.imageUrl
        }
        
        //print("prepare" + (destinationVC.fullName ?? "nil"))
        
    }
}


/*
 HATA:
 stroyboard'da VC table view cell -> secondVC segue oluşturunca, table view celle tıklayınca direkt segue çalışıyor
 bu da önce prepare sonra didselectrowat çalışmasına ve
 didselectrowat de oluşturduğum değeri prepare de nil oalrak görmeye sebep oluyor
 çözüm: vc den secondvc ye segue, ve didselectrow at de perform segue tetikleme.
 */
