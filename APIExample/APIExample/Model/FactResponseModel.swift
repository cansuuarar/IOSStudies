//
//  FactResponseModel.swift
//  APIExample
//
//  Created by CANSU ARAR on 17.10.2024.
//

import Foundation
//decodable: json objeyi swift objesine çevireceğiz. codable alias 
struct FactResponseModel: Codable {
    var data: [String]
}
