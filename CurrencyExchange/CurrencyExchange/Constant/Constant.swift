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
    // TODO: main currencies enum ile..
    
    static let alertTitleError = "ERROR"
    static let alertTitleSuccess = "SUCCESS"
    static let messageSuccessUserdefaults = "Currency saved successfuly userdefaults!"
    static let messageFailedDecode = "Failed to decode JSON"
    static let messageFailedUserdefaults = "Failed to save Currency userdefaults"
    static let buttonTitleOk = "OK"
    static let buttonTitleCancel = "Cancel"
}
