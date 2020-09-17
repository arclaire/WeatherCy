//
//  WFAddCountry.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class WFAddCountry: NSObject {
    var presenter: PAddCountry?
    var vc: VCAddCountry?
    var vcGotPresent: VCListWeatherCountry?
    
    func show(vc: VCListWeatherCountry, data: [ModelCountry]) {
        self.vcGotPresent = vc
        self.vc = self.initiateVC()
        self.vc?.eventHandler = self.presenter
        self.presenter?.model = data
        self.vc?.eventHandler?.model = data
        self.presenter?.vc = self.vc
        vc.navigationController?.present(self.vc!, animated: true)
    }
    
    func initiateVC() -> VCAddCountry {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_AddCountry) as! VCAddCountry
        
        return viewController
    }
    
    func updateVCPresented(){
        self.vcGotPresent?.eventHandler?.updateView()
    }
}
