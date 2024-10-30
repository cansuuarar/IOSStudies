//
//  KeychainHelper.swift
//  ThronesAPI
//
//  Created by CANSU ARAR on 29.10.2024.
//

import Foundation
import Security

class KeychainManager {
    
    enum KeychainError: Error {
        case noData
        case duplicateEntry
        case unknown(OSStatus)
        case decodeFailure
    }
    
    static func save(character: CharacterModel) throws {
        // service, account, password, clas
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(character) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: character.fullName,
                kSecValueData as String: data
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateEntry
            }
            
            guard status == errSecSuccess else {
                throw KeychainError.unknown(status)
            }
        }
    }
    
    static func get() throws -> CharacterModel? {
        // service, account, class, retrun-data, matchlimit
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
           // kSecAttrAccount as String: fullName,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
            
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else { throw KeychainError.unknown(status) }
        
        // Veriyi çözümle
        if let data = result as? Data {
            let decoder = JSONDecoder()
            let character = try decoder.decode(CharacterModel.self, from: data)
            return character
        }
        return nil
    }
    
}
