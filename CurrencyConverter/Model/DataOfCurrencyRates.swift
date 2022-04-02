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
//    init () {
//        dataCurrency.currencyModel = loadDataOfCurrencyModel()
//        if let date = UserDefaults.standard.object(forKey: "date") as? Date {
//            self.dateLastUpdata = date
//            print(self.dateLastUpdata)
//        } else {
//            print(self.dateStart)
//        }
//        if dateLastUpdata < dateStartMinusDay {
//            if editBank.editBank == .privatBank {
//                dataCurrency.dataOfPrivatbank()
//            } else {
//                dataCurrency.dataOfMonobank()
//            }
//            dateLastUpdata = dateStart
//        }
//        if  dataCurrency.currencyModel.isEmpty {
////            array = currencyUpdate()
////            dateLastUpdata = dateStart
//            print("dataCurrency.currencyModel is empty")
//        }
//    }
    
    func dataOfPrivatbank() {
       // currencyModel = []
        data.currencyUpdatePrivat(handler:  {  [self] currency in
            data.array = currency
        for i in data.array {
            self.currency = CurrencyModel(name: i.currencyName,
                                          buy: i.buy,
                                          sale: i.sale,
                                          rate: "")
            if let curr = self.currency {
                currencyModel.append(curr)
                
            }
        }
         //   print(currencyModel)
//            if data.dateLastUpdata < data.dateStartMinusDay {
            saveCurrencyModel(array: currencyModel)
//            }
    })
}
    
    func dataOfMonobank() {
      //  currencyModel = []
        data.currencyUpdateMono(handler: { [self] currency in
            data.dictionary = currency
            for i in data.dictionary {
                self.currency = CurrencyModel(name: String(i.currencyCodeA ?? 0),
                                              buy: String(i.rateBuy ?? 0),
                                              sale: String(i.rateSell ?? 0),
                                              rate: String(i.rateCross ?? 0))
                if let curr = self.currency {
                    self.currencyModel.append(curr)
                }
            }
            
            currencyModel.indices.forEach({
                for i in dictionaryIso4217 {
                    if i.value == currencyModel[$0].name {
                        currencyModel[$0].name = i.key
                    }
                }
            })
           // print("ArrayMono - \(currencyModel)")
//            if data.dateLastUpdata < data.dateStartMinusDay {
            saveCurrencyModel(array: currencyModel)
//            }
        })
        
    }
    
    func saveCurrencyModel(array: [CurrencyModel]) {
//        let userDefaults = UserDefaults()
//        userDefaults.standart(array, forKey: "currency")
        let defaults = UserDefaults.standard
        let key = "currency"
        
//        if let userModel = newValue {
            if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false) {
                print("value: \(array) was added to key \(key)")
                defaults.set(savedData, forKey: key)
//            } else {
//                defaults.removeObject(forKey: key)
            }
    }
}



