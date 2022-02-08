//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 14.11.2021.

import UIKit

class Currency {
    struct JsonCurrencyStruct: Codable {
        
        enum CodingKeys: String, CodingKey {
            case baseCurencyName = "base_ccy"
            case buy
            case currencyName = "ccy"
            case sale
        }
        
        var baseCurencyName: String
        var buy: String
        var currencyName: String
        var sale: String
    }
    var array: [JsonCurrencyStruct] = []
    let dateStart = Date()
    var dateLastUpdata = Date()
    var dateStartMinusDay = Date() - 86400
    init () {
        array = loadData()
        if let date = UserDefaults.standard.object(forKey: "date") as? Date {
            self.dateLastUpdata = date
            print(self.dateLastUpdata)
        } else {
            print(self.dateStart)
        }
        if dateLastUpdata < dateStartMinusDay {
            array = currencyUpdate()
            dateLastUpdata = dateStart
        }
        if array.isEmpty {
            array = currencyUpdate()
            dateLastUpdata = dateStart
        }
    }
    
    func currencyUpdate () -> [JsonCurrencyStruct] {

        guard let url = URL(string: "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11") else {
            return []
        }
        let session = URLSession.shared
        session.dataTask(with: url) { [self] (data, response, error) in
            guard let response = response,
                  let data = data else { return }
            print(response)
            do {
                let currencyOfBank: [JsonCurrencyStruct] = try JSONDecoder().decode([JsonCurrencyStruct].self, from: data)
                print(currencyOfBank)
                self.array = []
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
                print(self.array)
                // saveData()
                return
            }
            catch {
                print(error)
            }
        } .resume()
        return self.array
    }
    
    func loadData() -> [JsonCurrencyStruct] {
        var loadArray: [JsonCurrencyStruct] = []
        if let data = UserDefaults.standard.data(forKey: "currency") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let currency = try decoder.decode([JsonCurrencyStruct].self, from: data)
                loadArray = currency
                return currency
            } catch {
                print("Unable to Decode Currency (\(error))")
            }
        }
        
        return loadArray
    }
    
}

