//
//  AppDepedencies.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        let wf = AppDependencies.configureDependecy()
        wf.presentVCToWindow(window)
    }
    
    class func configureDependecy() -> WFListWeatherCountry {
        let wfListCountry = WFListWeatherCountry()
     
        let rootWireframe = WFRoot()
        
        let presenter = PListWeatherCountry()
        let datamanager = ManagerWeatherData()
        let interactor = IListWeatherCountry(manager: datamanager)
        
        presenter.interactor = interactor
        presenter.wfVc = wfListCountry
        
        wfListCountry.presenter = presenter
        wfListCountry.wfRoot = rootWireframe
    
        
        return wfListCountry
    }
    
    deinit {
        print("deinit")
    }
}
