//
//  PrivatBankJsonStruct.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 17.02.2022.
//

import Foundation

typealias privatBank = PrivatBankJsonStruct
struct PrivatBankJsonStruct: Codable {
    
    enum CodingKeys: String, CodingKey {
        case baseCurencyName = "base_ccy"
        case buy
        case currencyName = "ccy"
        case sale
    }
    
    var baseCurencyName: String
    var buy: String
    var currencyName: String
    var sale: String
}
