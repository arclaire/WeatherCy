//
//  ModelWeather.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation
class ModelWeather: Codable {
    var main:String?
    var description: String?
    
    
}

struct ModelWeatherDetail: Codable{
    var temp_max: Double?
    var temp_min: Double?
    var temp: Double?
    var name: String?
    var date: String?
    var day: String?
}

class ModelCountry: Codable {
    var country: String?
    var id: Int?
    var name: String?
}

class ModelCountryWeather: Codable {
    var name: String?
    var weather: [ModelWeather]?
    var main: ModelWeatherDetail?
    var sys: ModelCountry?
    var id: Int?
}

class ModelListWeather: Codable {
    var list: [ModelCountryWeather]?
}
