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
    // let currency = Currency()
    let array = [CurrencyConversion]()
    var data = DataOfCurrencyRates()
    
    init(name: String, sale: String?) {
        self.name = name
        self.baseCurrency = false
        self.value = fill(name: self.name)
    }
    
    func fill(name: String) -> String {
        var returnValue = ""
        for i in data.currencyModel {
            if name == i.name && self.baseCurrency == false {
                returnValue = i.sale
                // return returnValue
            }
        }
        return returnValue
    }
    
    
    func fill2(arrayCurrencies: [CurrencyModel], name: String, value: String, baseExchange: String?, baseValue: String?) -> String {
        print(data.currencyModel)
        var rate = ""
        var dRate: Double = 0
        var num: Double = 0
        var num2: Double = 0
        var koef: Double = 0
        var by = ""
        //        if let temp = Double(baseValue ?? "") {
        //            num = temp
        //        }
        print(arrayCurrencies)
        for i in arrayCurrencies {
            if i.name == baseExchange {
                rate = i.buy
                if rate == "0.0" {
                    rate = i.buy
                }
                
                print(rate)
                if let x = Double(rate) {
                    dRate = x
                }
            } else {
                // koef = Double(i.buy) ?? 0
                print("not baseExchange")
            }
        }
        for j in arrayCurrencies {
            if j.name == baseExchange {
                continue
            } else {
                if j.name == name {
                    if let temp = Double(baseValue ?? "") {
                        num = temp
                    }
                    if let temp2 = Double(j.buy) {
                        num2 = temp2
                    }
                }
                if num2 > 1 {
                    koef = num * (dRate / num2) * 10
                } else {
                    koef = (num * (num2 * dRate)) * 100
                }
            }
        }
        return String(koef)
    }
}


