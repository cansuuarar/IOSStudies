//
//  NetworkManager.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import UIKit
import Alamofire
import SwiftAlertView

final class NetworkManager {
    private static let BASE_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    static let shared = NetworkManager()
    
    func getWordDefinitions(word: String, completionBlock: @escaping ([DictionaryApiResponse]) -> Void) {
        let url = NetworkManager.BASE_URL + word
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
                let decoded = try
                decoder.decode([DictionaryApiResponse].self, from: data)
                completionBlock(decoded)
            }
            catch {
                SwiftAlertView.show(title: "ERROR", message: "Failed to decode JSON", buttonTitles: "OK", "Cancel")
            }
        }
    }
    
}
