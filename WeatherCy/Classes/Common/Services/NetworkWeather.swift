//
//  NetworkWeather.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class NetworkWeather {
    class func fetchDefaultWeather(string: String) -> Observable<ModelCountryWeather?> {
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
    class func fetchGrouptWeather(arr:[Int]) -> Observable<ModelListWeather?> {
        //q={city name}&appid={your api key}//9383
        //http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
        //http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
        var strids = "id=";
        for (index,id) in arr.enumerated() {
            if index < arr.count - 1 {
                strids = strids + "\(id)" + ","
            } else {
                strids = strids + "\(id)"
            }
            
        }
        //https://samples.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric&appid=439d4b804bc8187953eb36d2a8c26a02
        
        let strParam = "group?" + strids + "&units=metric&appid=\(API_KEY_WEATHER)"
        let url = NetworkConfigurations.properBaseUrl + strParam
//        let param: [String: Any] = ["id": arr,
//                                    "units": "metric",
//        ]
        //api.openweathermap.org/data/2.5/weather?q=London//.get(url, params:nil , bodyParams: param)
        //
        return NetworkProvider().get(url, params:nil , bodyParams: nil).map { response in
            
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decode = try JSONDecoder().decode(ModelListWeather.self, from: jsonData)
                    return decode
                } catch let error {
                    print(error)
                }
            }
            
            return nil
        }
    }
}
