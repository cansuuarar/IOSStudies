//
//  NetworkManager.swift
//  EnglishDictionary
//
//  Created by CANSU ARAR on 23.11.2024.
//

import UIKit
import Alamofire
import SwiftAlertView

class NetworkManager {
    // https://api.dictionaryapi.dev/api/v2/entries/en/hello
    private static let BASE_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    static let shared = NetworkManager()
    
    //private static let versionAPI = "v2"
    //private static let entry = "entries"
    //private static let languageKey = "en"

    
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
                print("JSON çözümleme hatası: \(error)")
                SwiftAlertView.show(title: "ERROR", message: "Failed to decode JSON", buttonTitles: "OK", "Cancel")
            }
        }
    }
    
}
