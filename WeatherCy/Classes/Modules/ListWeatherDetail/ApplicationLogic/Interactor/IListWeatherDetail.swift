//
//  IListWeatherDetail.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class IListWeatherDetail: BaseViewModel {
    
    var dataManager : ManagerWeatherData
    
    var modelListCountry: [ModelCountry]?
    
    init(manager: ManagerWeatherData) {
        self.dataManager = manager
        self.modelListCountry = self.dataManager.loadJson(filename: "cities")
        
    }
    
    
    func fetchDummyForecastWeekly(total: Int) -> [ModelWeatherDetail] {
        var arrModel: [ModelWeatherDetail] = []
        for i in 0..<total {
            var model : ModelWeatherDetail = ModelWeatherDetail()
            model.temp_min = Double.random(in: 12 ..< 15)
            model.temp_max = Double.random(in: 20 ..< 30)
            var date = Date()
            let format = DateFormatter()
            format.dateFormat = "EE"//"yyyy-MM-dd HH:mm:ss"
            if i > 0 {
                date = date.getDate(dayDifference: i)
            }
            let str = format.string(from: date)
            model.day = str
            if i % Int.random(in: 1 ..< 4) == 0 {
                model.name = "clouds"
            } else {
                model.name = "clear"
            }
            arrModel.append(model)
        }
        
        
        return arrModel
    }
    
    func fetchDummyForecastHourly(total: Int) -> [ModelWeatherDetail] {
        var arrModel: [ModelWeatherDetail] = []
        for i in 0..<total {
            var model : ModelWeatherDetail = ModelWeatherDetail()
            model.temp_min = Double.random(in: 12 ..< 15)
            model.temp_max = Double.random(in: 20 ..< 30)
            model.temp = Double.random(in: 15 ..< 27)
            var date = Date()
            let format = DateFormatter()
            format.dateFormat = "HH"//"yyyy-MM-dd HH:mm:ss"
            if i > 0 {
                date = date.getDatebyHour(dayDifference: i)
            }
            let str = format.string(from: date)
            model.date = str + ":00"
            if i % Int.random(in: 1 ..< 4) == 0 {
                model.name = "clouds"
            } else {
                model.name = "clear"
            }
            arrModel.append(model)
        }
        
        
        return arrModel
    }
    
    //MARK:- API NOT USABLE BECAUSE ITS NOT FREE
    func fetchForecast14Days(id: Int) -> Observable<ModelListWeather?> {
        //api.openweathermap.org/data/2.5/forecast/daily?id={city ID}&cnt={cnt}&appid={your api key}
        let strAPIKey = "&appid=\(API_KEY_WEATHER)"
        let strID = "id=\(id)"
        let strParam = "forecast/daily?" + strID + "&cnt=14" + "&units=metric"+strAPIKey
        
        let url = NetworkConfigurations.properBaseUrl + strParam
    
        return NetworkProvider().get(url).map { response in
            
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
    
    func fetchForecast14Hourly(id: Int) -> Observable<ModelListWeather?> {
        //pro.openweathermap.org/data/2.5/forecast/hourly?id={city ID}&appid={your api key}
        let strAPIKey = "&appid=\(API_KEY_WEATHER)"
        let strID = "id=\(id)"
        let strParam = "forecast/hourly?" + strID + strAPIKey
        
        let url = NetworkConfigurations.properBaseUrl + strParam
    
        return NetworkProvider().get(url).map { response in
            
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
