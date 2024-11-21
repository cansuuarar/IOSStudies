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
    private static let BASE_URL = "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/try.json"
    static let shared = NetworkManager()
    
    func getCurrencies(completionBlock: @escaping (Currency) -> Void) {
        let url = NetworkManager.BASE_URL
        handleRequest(url: url, responseType: Currency.self) { response in
            completionBlock(response)
        }
        
    }
    
    private func handleRequest<T: Codable>(url: String, responseType: T.Type, completionBlock: @escaping (T) -> Void) {
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
                let decoded = try
                decoder.decode(T.self, from: data)
                completionBlock(decoded)
            }
            catch let decodingError {
                    print("Decoding error: \(decodingError)")
            }
        }
    }
}

