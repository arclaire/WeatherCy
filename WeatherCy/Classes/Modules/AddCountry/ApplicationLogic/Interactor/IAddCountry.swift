//
//  IAddCountry.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class IAddCountry {
    
    var dataManager : ManagerWeatherData
    
     var modelListCountry: [ModelCountry]?
     
     init(manager: ManagerWeatherData) {
         self.dataManager = manager
         self.modelListCountry = self.dataManager.loadJson(filename: "cities")
         
     }
    
    func saveNewCitiesWeather(intId: Int) {
        var arrID = self.dataManager.getSavedCountryID()
        arrID.append(intId)
        let arrnew = Array(Set(arrID))
        self.dataManager.saveArrayOfCountryID(array: arrnew)
        
    }
}
