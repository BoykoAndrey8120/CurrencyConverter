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
    let dateStart = Date()
    var dateLastUpdata = Date()
    var dateStartMinusDay = Date() - 86400
    var editBank = Links()
    var dataCurrency: DataOfCurrencyRates?
//    var ar: [String] = []
//    init () {
//        DispatchQueue.main.async { [self] in
//        if editBank.editBank == .privatBank {
//            array = loadDataPrivat()
//            if let date = UserDefaults.standard.object(forKey: "date") as? Date {
//                self.dateLastUpdata = date
//                print(self.dateLastUpdata)
//            } else {
//                print(self.dateStart)
//                if dateLastUpdata < dateStartMinusDay {
//                    //        if link == Link.urlPrivatBank.rawValue {
//                    //  DispatchQueue.main.async { [self] in
//                    array = self.currencyUpdatePrivat()
//                    print(array)
//                }
//            }
//        } else {
//            dictionary = loadDataMono()
//            if let date = UserDefaults.standard.object(forKey: "date") as? Date {
//                self.dateLastUpdata = date
//                print(self.dateLastUpdata)
//            } else {
//                print(self.dateStart)
//                if dateLastUpdata < dateStartMinusDay {
//                    dictionary = self.currencyUpdateMono()
//                    print(dictionary)
//                }
//            }
//        }
//    }
//    }
    
    func createResponse() {
       // editBank.changeBank()
        DispatchQueue.main.async { [self] in
        if editBank.editBank == .monoBank {
            array = loadDataPrivat()
            if let date = UserDefaults.standard.object(forKey: "date") as? Date {
                dateLastUpdata = date
                print(dateLastUpdata)
            } else {
                print(dateStart)
                if dateLastUpdata < dateStartMinusDay {
                    //        if link == Link.urlPrivatBank.rawValue {
                    //  DispatchQueue.main.async { [self] in
                    array = currencyUpdatePrivat()
                    print(array)
                }
            }
        } else {
            dictionary = loadDataMono()
            if let date = UserDefaults.standard.object(forKey: "date") as? Date {
                dateLastUpdata = date
                print(dateLastUpdata)
            } else {
                print(dateStart)
                if dateLastUpdata < dateStartMinusDay {
                    dictionary = currencyUpdateMono()
                    print(dictionary)
                }
            }
        }
    }
        editBank.changeBank()
    }
    
    func currencyUpdatePrivat () -> [PrivatBankJsonStruct] {
        
        guard let url = URL(string: editBank.link) else {
            return []
        }
        let session = URLSession.shared
        session.dataTask(with: url) { [self] (data, response, error) in
            guard let response = response,
                  let data = data else { return }
            print(response)
            do {
                let currencyOfBank: [PrivatBankJsonStruct] = try JSONDecoder().decode([PrivatBankJsonStruct].self, from: data)
               // print(currencyOfBank)
               // self.array = []
                self.array = currencyOfBank
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(self.array)
                    
                    UserDefaults.standard.set(data, forKey: "currency")
                    UserDefaults.standard.set(self.dateStart, forKey: "date")
                    print("it saved")
                } catch {
                    print("Unable to Encode Currency (\(error))")
                }
                print("update")
               // print(self.array)
                // saveData()
                return
            }
            catch {
                print(error)
            }
        } .resume()
        return self.array
    }
    
    func currencyUpdateMono () -> [MonoBankJsonStruct] {
        let parameters = ["Address":""] as [String : Any]
        AF.request(editBank.link, method: .get, parameters: parameters).validate().responseJSON { [self] response in
            switch response.result {
            
            case .success(let value):
                let json = JSON(value)
                let numberOfCurrencies = json[].count
                print("numberOfCurrencies: \(numberOfCurrencies)")
                //print("JSON!!!!!!!!!!!!: \(json)")
//                for (key, i) in dictionaryIso4217 {
//                    for j in 0..<numberOfCurrencies {
//                        if i == String(json[j]["currencyCodeA"].int ?? 0) {
//                           // array.append(key, i)
//                            ar.append((String(json[j]["currencyCodeA"].int ?? 0), String(json[j]["rateCross"].double ?? 0), String(json[j]["date"].int ?? 0), key))
            
//                        }
//                    }
                do {
                    if let data = response.data {
                    let monoBankCurrencies: [MonoBankJsonStruct] = try JSONDecoder().decode([MonoBankJsonStruct].self, from: data)
               // print(monoBankCurrencies)
                                    
                        dictionary = monoBankCurrencies
                      //  print(dictionary)
                        }

            } catch {
                print(error)
            }
            case .failure(let error):
                print(error)
            }
    }
       
          
//        guard let url = URL(string: editBank.link2) else {
//            return []
//        }
//        let session = URLSession.shared
//        session.dataTask(with: url) { [self] (data, response, error) in
//            guard let response = response,
//                  let data = data else { return }
//            print(response)
//            do {
//                let currencyOfBank: [MonoBankJsonStruct] = try JSONDecoder().decode([MonoBankJsonStruct].self, from: data)
//                print(currencyOfBank)
//                self.dictionary = []
//                self.dictionary = currencyOfBank
//                do {
//                    let encoder = JSONEncoder()
//                    let data = try encoder.encode(self.dictionary)
//
//                    UserDefaults.standard.set(data, forKey: "currency2")
//                    UserDefaults.standard.set(self.dateStart, forKey: "date")
//                    print("it saved")
//                } catch {
//                    print("Unable to Encode Currency (\(error))")
//                }
//                print("update")
//                print(self.dictionary)
//                // saveData()
//                return
//            }
//            catch {
//                print(error)
//            }
//        } .resume()
//        return self.dictionary
        print("DDDDDDDDD: \(dictionary.first)")
        return dictionary
        }
   
    func loadDataPrivat() -> [PrivatBankJsonStruct] {
        var loadArray: [PrivatBankJsonStruct] = []
        if let data = UserDefaults.standard.data(forKey: "currency") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let currency = try decoder.decode([PrivatBankJsonStruct].self, from: data)
                loadArray = currency
                return currency
            } catch {
                print("Unable to Decode Currency (\(error))")
            }
        }
        
        return loadArray
    }
    
    func loadDataMono() -> [MonoBankJsonStruct] {
        var loadArray: [MonoBankJsonStruct] = []
        if let data = UserDefaults.standard.data(forKey: "currency2") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let currency = try decoder.decode([MonoBankJsonStruct].self, from: data)
                loadArray = currency
                return currency
            } catch {
                print("Unable to Decode Currency (\(error))")
            }
        }
        
        return loadArray
    }
}

