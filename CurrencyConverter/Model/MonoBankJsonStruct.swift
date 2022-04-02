//
//  MonoBankJsonStruct.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 17.02.2022.
//

import Foundation

typealias monoBank = MonoBankJsonStruct
struct MonoBankJsonStruct: Decodable, Encodable {
    enum CodingKeys: String, CodingKey {
        case rateCross = "rateCross"
        case rateBuy = "rateBuy"
        case rateSell = "rateSell"
        case currencyCodeA = "currencyCodeA"
        case date = "date"
        case currencyCodeB = "currencyCodeB"
    }
    var currencyCodeB: Int?
    var date: Int?
    var rateBuy: Double?
    var rateSell: Double?
    var currencyCodeA: Int?
    var rateCross: Double?
}
