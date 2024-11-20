//
//  Constant.swift
//  CurrencyExchange
//
//  Created by CANSU ARAR on 17.11.2024.
//

import Foundation

final class Constant {
    static let mainCurrencies = [
        "all",
        "ang",
        "ars",
        "ats",
        "aud",
        "azm",
        "bch",
        "cad",
        "cny",
        "dem",
        "eur",
        "gbp",
        "hkd",
        "jpy",
        "kwd",
        "nft",
        "try",
        "usd",
        "zar",
        "zwl"
    ]
    
    static let alertTitle = "ERROR"
    static let alertTitleSuccess = "SUCCESS"
    static let messageSuccessUserdefaults = "Currency saved successfuly userdefaults!"
    static let messageSuccessKeychain = "Currency saved successfuly Keychain!"
    static let messageFailedDecode = "Failed to decode JSON"
    static let messageFailedUserdefaults = "Failed to save Currency userdefaults"
    static let buttonTitleOk = "OK"
    static let buttonTitleCancel = "Cancel"
}
