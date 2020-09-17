//
//  WFListWeatherDetail.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class WFListWeatherDetail: NSObject {
    var presenter: PListWeatherDetail?
    var vc: VCListWeatherDetail?
    func push(vc: UIViewController, data: ModelCountryWeather) {
        self.vc = self.initiateVC()
        self.vc?.model = data
        vc.navigationController?.pushViewController(self.vc!, animated: true)
    }
    
    func initiateVC() -> VCListWeatherDetail {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_ListWeatherDetail) as! VCListWeatherDetail
        viewController.eventHandler = self.presenter
        self.presenter?.vc = viewController
        return viewController
    }
    
}
