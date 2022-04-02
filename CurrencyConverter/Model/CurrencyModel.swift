//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 12.03.2022.
//

import Foundation

struct CurrencyModel: Codable {
    var name: String = ""
    var buy: String = ""
    var sale: String = ""
    var rate: String = ""
}
