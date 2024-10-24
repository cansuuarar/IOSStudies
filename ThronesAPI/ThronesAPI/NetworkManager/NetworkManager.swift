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
    /*
    func getCharacterId(id: Int, completionBlock: @escaping ([CharacterModel]) -> Void) {
        let url = NetworkManager.BASE_URL + String(id)
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
               // print(String(data: data, encoding: .utf8)!)
                let decoded = try
                decoder.decode(CharacterModel.self, from: data)
                //completionBlock(decoded.fullName)
            } catch {
                SwiftAlertView.show(title: "ERROR",
                                    message: "Failed to decode JSON",
                                    buttonTitles: "OK", "Cancel")
            }
        }
    }
     */
    
    func getCharacter(completionBlock: @escaping ([CharacterModel]) -> Void) {
        let url = NetworkManager.BASE_URL
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
               // print(String(data: data, encoding: .utf8)!)
                let decoded = try
                decoder.decode([CharacterModel].self, from: data)
                print("decoded ok")
                completionBlock(decoded)
            } catch {
                SwiftAlertView.show(title: "ERROR",
                                    message: "Failed to decode JSON",
                                    buttonTitles: "OK", "Cancel")
            }
        }
    }
    
    
    func getCharactersFullName(completionBlock: @escaping ([String]) -> Void) {
        let url = NetworkManager.BASE_URL
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
                //print(String(data: data, encoding: .utf8)!)
                let decoded = try
                decoder.decode([CharacterModel].self, from: data)
                //print("decode işlemi?")
                var array: [String] = []
                for character in decoded {
                    array.append(character.fullName)
                }
                completionBlock(array)
            } catch {
                SwiftAlertView.show(title: "ERROR",
                                    message: "Failed to decode JSON",
                                    buttonTitles: "OK", "Cancel")
            }
        }
    }
}
