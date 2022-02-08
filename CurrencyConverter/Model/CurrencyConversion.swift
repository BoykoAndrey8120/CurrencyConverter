//
//  CurrencyConversion.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 09.12.2021.
//


import Foundation

class CurrencyConversion {
    
    weak var delegate: ValueChangedDelegat?
    var name: String
    var value: String = "" {
        didSet {
            delegate?.valueChanged(text: value, nameCurrency: name)
        }
    }
    var baseExchange: String?
    var baseCurrency: Bool
    var currencySale: String?
    let currency = Currency()
    let array = [CurrencyConversion]()
    
    init(name: String, sale: String?) {
        self.name = name
        self.baseCurrency = false
        self.value = fill(name: self.name)
    }
    
    func fill(name: String) -> String {
        var returnValue = ""
        for i in currency.array {
            if name == i.currencyName && self.baseCurrency == false {
                returnValue = i.buy
                return returnValue
            }
        }
        return returnValue
    }
    
    func fill2(name: String, value: String, baseExchange: String?, baseValue: String?) -> String {
        var rate = ""
        var num: Double = 0
        var num2: Double = 0
        var koef: Double = 0
        var by = ""
        
        for i in currency.array {
            if i.currencyName == baseExchange {
                rate = i.buy
            }
        }
        for j in currency.array {
            if j.currencyName == baseExchange {
                continue
            } else {
                if j.currencyName == name {
                    if let temp = Double(baseValue ?? "") {
                        num = temp
                        if let temp2 = Double(j.buy) {
                            num2 = temp2
                        }
                    }
                }
                if num2 > 1 {
                    koef = num2 / num
                } else {
                    koef = (num2 * num) * 100
                }
            }
        }
        return String(koef)
    }
}

