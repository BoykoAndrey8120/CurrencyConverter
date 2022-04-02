//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 14.11.2021.

import UIKit
import Alamofire
import SwiftyJSON

class Currency {
    
    var array: [PrivatBankJsonStruct] = []
    var dictionary: [MonoBankJsonStruct] = []
    var temp: MonoBankJsonStruct?
    let dateStart = Date()
    var dateLastUpdata = Date()
    var dateStartMinusDay = Date() - 86400
    var editBank = Links()
    var dataCurrency: DataOfCurrencyRates?
    
    func createResponse() {
        DispatchQueue.main.async { [self] in
            if editBank.editBank == .privatBank {
                  //array = loadDataPrivat()
                if let date = UserDefaults.standard.object(forKey: "date") as? Date {
                    dateLastUpdata = date
                    print(dateLastUpdata)
                } else {
                    print(dateStart)
                    if dateLastUpdata < dateStartMinusDay {
                        print(array)
                    }
                }
            } else {
                if let date = UserDefaults.standard.object(forKey: "date") as? Date {
                    dateLastUpdata = date
                    print(dateLastUpdata)
                } else {
                    print(dateStart)
                    if dateLastUpdata < dateStartMinusDay {
                        print(dictionary)
                    }
                }
            }
        }
    }
    
    func currencyUpdatePrivat (handler: @escaping ([PrivatBankJsonStruct]) -> Void) {
        let parameters = ["Address":""] as [String : Any]
        AF.request(editBank.link2, method: .get, parameters: parameters)
            .responseDecodable(of: [PrivatBankJsonStruct].self, completionHandler: { response in
                if let value = response.value {
                    handler(value)
                }
                print("DDDDDDDDD: \(String(describing: self.array.first))")
            })
    }

    
    func currencyUpdateMono (handler: @escaping ([MonoBankJsonStruct]) -> Void) {
        let parameters = ["Address":""] as [String : Any]
        AF.request(editBank.link, method: .get, parameters: parameters)
            .responseDecodable(of: [MonoBankJsonStruct].self, completionHandler: { response in
                if let value = response.value {
                    handler(value)
                }
                print("DDDDDDDDD: \(String(describing: self.dictionary.first))")
            })
    }
    
//    func loadDataPrivat() -> [PrivatBankJsonStruct] {
//        var loadArray: [PrivatBankJsonStruct] = []
//        if let data = UserDefaults.standard.data(forKey: "currency") {
//            do {
//                // Create JSON Decoder
//                let decoder = JSONDecoder()
//
//                // Decode Note
//                let currency = try decoder.decode([PrivatBankJsonStruct].self, from: data)
//                loadArray = currency
//                return currency
//            } catch {
//                print("Unable to Decode Currency (\(error))")
//            }
//        }
//
//        return loadArray
//    }
//
//    func loadDataMono() -> [MonoBankJsonStruct] {
//        var loadArray: [MonoBankJsonStruct] = []
//        if let data = UserDefaults.standard.data(forKey: "currency2") {
//            do {
//                // Create JSON Decoder
//                let decoder = JSONDecoder()
//
//                // Decode Note
//                let currency = try decoder.decode([MonoBankJsonStruct].self, from: data)
//                loadArray = currency
//                return currency
//            } catch {
//                print("Unable to Decode Currency (\(error))")
//            }
//        }
//        return loadArray
//    }
    func loadDataOfCurrencyModel() -> [CurrencyModel] {
       // var loadArray: [CurrencyModel] = []
        guard let data = UserDefaults.standard.object(forKey: "currency") as? Data,
           let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CurrencyModel] else { return [] }
        return decodedModel
    }
//        {
//            do {
//                // Create JSON Decoder
//                let decoder = JSONDecoder()
//
//                // Decode Note
//                let currency = try decoder.decode([CurrencyModel].self, from: data)
//                loadArray = currency
//                return currency
//            } catch {
//                print("Unable to Decode Currency (\(error))")
//            }
//        }
//        return loadArray
//    }
    
//    guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel else { return nil }
//    return decodedModel
}

///////////////////////////////////

//class Currency {
//     struct JsonCurrencyStruct: Codable {
//
//         enum CodingKeys: String, CodingKey {
//             case baseCurencyName = "base_ccy"
//             case buy
//             case currencyName = "ccy"
//             case sale
//         }
//
//         var baseCurencyName: String
//         var buy: String
//         var currencyName: String
//         var sale: String
//     }
//     var array: [JsonCurrencyStruct] = []
//     let dateStart = Date()
//     var dateLastUpdata = Date()
//     var dateStartMinusDay = Date() - 86400
//     init () {
//         array = loadData()
//         if let date = UserDefaults.standard.object(forKey: "date") as? Date {
//             self.dateLastUpdata = date
//             print(self.dateLastUpdata)
//         } else {
//             print(self.dateStart)
//         }
//         if dateLastUpdata < dateStartMinusDay {
//             array = currencyUpdate()
//             dateLastUpdata = dateStart
//         }
//         if array.isEmpty {
//             array = currencyUpdate()
//             dateLastUpdata = dateStart
//         }
//     }
//
//     func currencyUpdate () -> [JsonCurrencyStruct] {
//
//         guard let url = URL(string: "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11") else {
//             return []
//         }
//         let session = URLSession.shared
//         session.dataTask(with: url) { [self] (data, response, error) in
//             guard let response = response,
//                   let data = data else { return }
//             print(response)
//             do {
//                 let currencyOfBank: [JsonCurrencyStruct] = try JSONDecoder().decode([JsonCurrencyStruct].self, from: data)
//                 print(currencyOfBank)
//                 self.array = []
//                 self.array = currencyOfBank
//                 do {
//                     let encoder = JSONEncoder()
//                     let data = try encoder.encode(self.array)
//
//                     UserDefaults.standard.set(data, forKey: "currency")
//                     UserDefaults.standard.set(self.dateStart, forKey: "date")
//                     print("it saved")
//                 } catch {
//                     print("Unable to Encode Currency (\(error))")
//                 }
//                 print("update")
//                 print(self.array)
//                 // saveData()
//                 return
//             }
//             catch {
//                 print(error)
//             }
//         } .resume()
//         return self.array
//     }
//
//     func loadData() -> [JsonCurrencyStruct] {
//         var loadArray: [JsonCurrencyStruct] = []
//         if let data = UserDefaults.standard.data(forKey: "currency") {
//             do {
//                 // Create JSON Decoder
//                 let decoder = JSONDecoder()
//
//                 // Decode Note
//                 let currency = try decoder.decode([JsonCurrencyStruct].self, from: data)
//                 loadArray = currency
//                 return currency
//             } catch {
//                 print("Unable to Decode Currency (\(error))")
//             }
//         }
//
//         return loadArray
//     }
//
// }
//
// 77  CurrencyConverter/Model/CurrencyConversion.swift
//
//@@ -0,0 +1,77 @@
// //
// //  CurrencyConversion.swift
// //  CurrencyConverter
// //
// //  Created by Andrey Boyko on 09.12.2021.
// //
//
//
// import Foundation
//
// class CurrencyConversion {
//
//     weak var delegate: ValueChangedDelegat?
//     var name: String
//     var value: String = "" {
//         didSet {
//             delegate?.valueChanged(text: value, nameCurrency: name)
//         }
//     }
//     var baseExchange: String?
//     var baseCurrency: Bool
//     var currencySale: String?
//     let currency = Currency()
//     let array = [CurrencyConversion]()
//
//     init(name: String, sale: String?) {
//         self.name = name
//         self.baseCurrency = false
//
