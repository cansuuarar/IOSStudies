//
//  Currency.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 16.11.2024.
//

import Foundation

final class Currency: Codable {
    var date: Date
    var currencyType: [String: Double]
    
    enum CodingKeys: String, CodingKey {
            case currencyType
            case date
        }
}
