//
//  Currency.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import Foundation

final class Currency: Codable {
    var date: String
    var typeCurrencies: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case date
        case typeCurrencies = "try" // "try" anahtarını "tryCurrencies" olarak map ediyoruz
    }
}