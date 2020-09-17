//
//  ManagerWeatherData.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class ManagerWeatherData {
    var userDefault = UserDefaults.standard
    
    func saveArrayOfCountryID (array: [Int]) {
        userDefault.set(array, forKey: "arrCountry")
    }
    
    func getSavedCountryID() -> [Int] {
        var arrCountry: [Int] = [1642911]
        if let arr =  userDefault.array(forKey: "arrCountry") as? [Int]{
            arrCountry = arr
        }
        return arrCountry
    }
    
    func getSavedListWeather() -> [ModelCountryWeather]?{
        if let arr = userDefault.array(forKey: "arrListWeather") as? [ModelCountryWeather] {
            return arr
        }
        return nil
    }
    
    func loadJson(filename fileName: String) -> [ModelCountry]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ModelCountry].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
