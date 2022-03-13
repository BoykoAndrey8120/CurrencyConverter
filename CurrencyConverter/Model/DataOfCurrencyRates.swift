//
//  DataOfCurrencyRates.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 09.03.2022.
//

import Foundation

class DataOfCurrencyRates {
    var data = Currency()
    var currencyModel: [CurrencyModel] = []
    var currency: CurrencyModel?
    
    
    func dataOfMonobank() {
       // if let bank = data {
            if data.editBank.editBank == .privatBank {
                DispatchQueue.main.async {
                    self.data.currencyUpdatePrivat()
                }
                for i in self.data.dictionary {
                    for j in dictionaryIso4217 {
                        if String(i.currencyCodeB) == j.value {
                            currency = CurrencyModel(name: j.key,
                                                     buy: String(i.rateBuy),
                                                     sale: String(i.rateSell),
                                                     rate: i.rateCross)
                            if let curr = currency {
                                currencyModel.append(curr)
                            }
                        }
                    }
                }
         //   }
        }
    }
    func dataOfPrivatbank() {
       // if let bank = data {
            if data.editBank.editBank == .monoBank {
                DispatchQueue.main.async {
                    self.data.currencyUpdateMono()
                }
                    for i in self.data.array {
                        self.currency = CurrencyModel(name: i.currencyName,
                                             buy: i.buy,
                                             sale: i.sale,
                                             rate: "")
                        if let curr = self.currency {
                            self.currencyModel.append(curr)
                    }
                }
                
            }
        }
    }

