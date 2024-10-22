//
//  NetworkManager.swift
//  APIExample
//
//  Created by CANSU ARAR on 17.10.2024.
//

import Foundation
import Alamofire
import SwiftAlertView

final class NetworkManager {
    
    static let BASE_URL = "https://meowfacts.herokuapp.com/"
    static let shared = NetworkManager()
        
    func getFacts(count: Int, completionBlock: @escaping ([String]) -> Void) {
        let url = NetworkManager.BASE_URL + "?count=" + String(count)
        AF.request(url).response { response in
            let decoder = JSONDecoder()
            do {
                guard let data = response.data else { return }
                let decoded = try
                decoder.decode(FactResponseModel.self, from: data)
                completionBlock(decoded.data)
            } catch {
                SwiftAlertView.show(title: "ERROR",
                                    message: "Failed to decode JSON",
                                    buttonTitles: "OK", "Cancel")
            }
        }
    }
}
