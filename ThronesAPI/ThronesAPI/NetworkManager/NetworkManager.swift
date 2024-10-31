//
//  NetworkManager.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 21.10.2024.
//

import Foundation
import Alamofire
import SwiftAlertView
import SDWebImage

final class NetworkManager {
    static let BASE_URL = "https://thronesapi.com/api/v2/Characters/"
    static let shared = NetworkManager()
    
    func getCharacters(completionBlock: @escaping ([CharacterModel]) -> Void) {
        let url = NetworkManager.BASE_URL
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
                let decoded = try
                decoder.decode([CharacterModel].self, from: data)
                completionBlock(decoded)
            } catch {
                SwiftAlertView.show(title: Constant.alertTitle,
                                    message: Constant.messageFailedDecode,
                                    buttonTitles: Constant.buttonTitleOk, Constant.buttonTitleCancel)
            }
        }
    }
}
