//
//  MonoBankJsonStruct.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 17.02.2022.
//

import Foundation

typealias monoBank = MonoBankJsonStruct
struct MonoBankJsonStruct: Decodable, Encodable {
//    enum CodingKeys: String, CodingKey {
//        case rateCross
//        case rateBuy
//        case rateSell
//        case currencyCodeA
//        case date
//        case currencyCodeB
//    }
    
    var currencyCodeB: Int
//    var date: Int
    var rateBuy: Double
    var rateSell: Double
    var currencyCodeA: Int
    var rateCross: String
    
//    var rateCross: Double
//    var rateBuy: Double
//    var rateSell: Double
//    var currencyCodeA: Int
//    var date: Int
//    var currencyCodeB: Int
}

