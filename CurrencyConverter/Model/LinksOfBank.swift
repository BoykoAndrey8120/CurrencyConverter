//
//  LinksOfBank.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 21.02.2022.
//

import Foundation

class Links {
enum Link: String {
    case urlPrivatBank = "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11"
    case urlMonobank = "https://api.monobank.ua/bank/currency"
}
enum BankAPI: String {
    case privatBank
    case monoBank
}
var link2 = Link.urlPrivatBank.rawValue
var link = Link.urlMonobank.rawValue
var editBank = BankAPI.privatBank
    
    func changeBank() {
       
        if editBank == .privatBank {
        editBank = .monoBank
        } else {
        editBank = .privatBank
        }
    }
}
