//
//  WFListWeatherCountry.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation
import UIKit
class WFListWeatherCountry: NSObject {
    var vcListWeatherCountry: VCListWeatherCountry?
    var vcListWeatherDetail: VCListWeatherDetail?
    var wfRoot: WFRoot?
    var presenter : PListWeatherCountry?

    func presentVC(fromVC: UIViewController) {
        self.vcListWeatherCountry = self.initiateVC()
    }
    
    func initiateVC() -> VCListWeatherCountry {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_ListWeatherCountry) as! VCListWeatherCountry
        viewController.eventHandler = self.presenter
        self.presenter?.vc = viewController
        return viewController
    }
    
    func presentVCToWindow(_ window: UIWindow) {
        let viewController = initiateVC()
        wfRoot?.showRootViewController(viewController, inWindow: window)
    }
    
    func navigateToDetail(model: ModelCountryWeather) {
        let wfDetail = WFListWeatherDetail()
        
        var manager = ManagerWeatherData()
        if let dataManager = self.presenter?.interactor?.dataManager {
            manager = dataManager
        }
        let interactor = IListWeatherDetail(manager: manager)
        let presenter = PListWeatherDetail()
        presenter.interactor = interactor
        presenter.wfVc = wfDetail
        wfDetail.presenter = presenter
        
        wfDetail.push(vc: (self.presenter?.vc)!, data: model)
    }
    
    func presentVCAddCountry(data: [ModelCountry]) {
        let wfAdd = WFAddCountry()
        var manager = ManagerWeatherData()
        if let dataManager = self.presenter?.interactor?.dataManager {
            manager = dataManager
        }
        let interactor = IAddCountry(manager: manager)
        let presenter = PAddCountry()
        presenter.interactor = interactor
        presenter.wfVc = wfAdd
        wfAdd.presenter = presenter
        wfAdd.show(vc: self.presenter?.vc! ?? self.vcListWeatherCountry!, data: data)
    }
    
    func displayAlert(title: String? = nil, message: String? = nil) {

        var titleString = "Error"
        var messageString = message
        if title != nil {
            titleString = title!
        }
        if message != nil {
            messageString = message!
        }
        
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.vcListWeatherCountry?.present(alertController, animated: true, completion: nil)
    }
}
