//
//  IListWeatherCountry.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class IListWeatherCountry:BaseViewModel {
    var dataManager : ManagerWeatherData
   
    var modelListCountry: [ModelCountry]?
    
    init(manager: ManagerWeatherData) {
        self.dataManager = manager
        self.modelListCountry = self.dataManager.loadJson(filename: "cities")
        
    }

    func fetchDefaultWeather(string: String) -> Observable<ModelCountryWeather?> {
        //q={city name}&appid={your api key}//9383
        let strParam = "weather?q=\(string)&appid=\(API_KEY_WEATHER)"
        let url = NetworkConfigurations.properBaseUrl + strParam
        
        //api.openweathermap.org/data/2.5/weather?q=London
        return NetworkProvider().get(url).map { response in
            
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decode = try JSONDecoder().decode(ModelCountryWeather.self, from: jsonData)
                    return decode
                } catch let error {
                    print(error)
                }
            }
            
            return nil
        }
    }
   
    func fetchGrouptWeather() -> Observable<ModelListWeather?> {
        let arr = self.dataManager.getSavedCountryID()
        var strids = "id=";
        for (index,id) in arr.enumerated() {
            if index < arr.count - 1 {
                strids = strids + "\(id)" + ","
            } else {
                strids = strids + "\(id)"
            }
            
        }
        
        let strParam = "group?" + strids + "&units=metric&appid=\(API_KEY_WEATHER)"
        let url = NetworkConfigurations.properBaseUrl + strParam
        return NetworkProvider().get(url, params:nil , bodyParams: nil).map { response in
            
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decode = try JSONDecoder().decode(ModelListWeather.self, from: jsonData)
                    return decode
                } catch let error {
                    print(error.localizedDescription)
                    
                }
            }
            
            return nil
        }
    }
}
