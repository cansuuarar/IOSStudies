//
//  DictionaryNetworkManager.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 10.12.2024.
//

import UIKit
import Alamofire
import SwiftAlertView

final class DictionaryNetworkManager {
    private static let BASE_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    static let shared = DictionaryNetworkManager()
    
    func getWordMeaning(word: String, completionBlock: @escaping ([Word]) -> Void) {
        let url = DictionaryNetworkManager.BASE_URL + word
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
                let decoded = try
                decoder.decode([Word].self, from: data)
                completionBlock(decoded)
            }
            catch {
                SwiftAlertView.show(title: "ERROR", message: "Failed to decode JSON", buttonTitles: "OK", "Cancel")
            }
        }
    }
    
}
