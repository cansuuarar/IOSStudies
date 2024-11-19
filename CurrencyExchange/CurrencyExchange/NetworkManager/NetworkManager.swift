//
//  NetworkManager.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import Foundation
import Alamofire
import SwiftAlertView

final class NetworkManager {
    static let BASE_URL = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/try.json"
    static let shared = NetworkManager()
    
    func getCurrencies(completionBlock: @escaping (Currency) -> Void) {
        let url = NetworkManager.BASE_URL
        
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            //print("Response: \(response.debugDescription)")
            do {
                guard let data = response.data else { return }
                let decoded = try
                decoder.decode(Currency.self, from: data)
                completionBlock(decoded)
                print("Decoded Currency: \(decoded)")
            }
            catch let decodingError {
                    print("Decoding error: \(decodingError)")
            }
        }
    }
}

