//
//  PAddCountry.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class PAddCountry: BaseViewModel {
    var wfVc: WFAddCountry?
    var interactor: IAddCountry?
    var vc : VCAddCountry?
    var model: [ModelCountry]?
    
    func dismissView(){
        self.vc?.dismiss(animated: true, completion: nil)

    }
    
    func filterModelWith(str: String) -> [ModelCountry] {
        var arr = [ModelCountry]()
        if let data = self.model {
            arr = data.filter {
                ($0.name?.lowercased().contains(str.lowercased()))!
            }
        }
        return arr
    }
    
    func selectNewCity(intID: Int) {
        self.interactor?.saveNewCitiesWeather(intId: intID)
        self.wfVc?.updateVCPresented()
        //print("XXXID", intID)
    }
}
