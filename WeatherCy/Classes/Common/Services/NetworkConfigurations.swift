//
//  NetworkConfigurations.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation


struct NetworkConfigurations {
    
    fileprivate static let DevBaseUrl = "https://api.openweathermap.org/data/2.5/"
    fileprivate static let ProdBaseUrl = "https://api.openweathermap.org/data/2.5/"
    
    fileprivate static let kClientSecret = ""
    
    
    //properBaseUrl will be lazy load and called only once on first access
    static var properBaseUrl: String = {
        #if DEBUG
        return DevBaseUrl
        #else
        return ProdBaseUrl
        #endif
    }()
    
    static func parseCurrentUrlHost() -> String {
        let currentBaseUrl = URL(string: properBaseUrl)!
        return currentBaseUrl.host!
    }
    
}
