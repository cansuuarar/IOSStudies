//
//  ViewController.swift
//  APIExample
//
//  Created by CANSU ARAR on 17.10.2024.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://meowfacts.herokuapp.com/?count=3").response { response in
            debugPrint(response)
        }
    }
}

