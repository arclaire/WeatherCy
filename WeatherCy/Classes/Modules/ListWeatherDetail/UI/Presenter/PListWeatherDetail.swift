//
//  PListWeatherDetail.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class PListWeatherDetail: BaseViewModel {
    var presenter : PListWeatherDetail?
    var vc : VCListWeatherDetail?
    
    var wfVc: WFListWeatherDetail?
    var interactor: IListWeatherDetail?
    
    var dataSourceObservable = BehaviorRelay<ModelListWeather?>(value:nil)
    var dataSource: ModelListWeather? {
        get {
            return dataSourceObservable.value
        }
        set {
            dataSourceObservable.accept(newValue)
        }
    }
    
    var dataWeekly: [ModelWeatherDetail]?
    var dataHourly: [ModelWeatherDetail]?
    
    func updateViewForecastWeekly(id: Int) {
        //self.vc?.loadingView.isHidden = false
        //self.vc?.loadingView.startAnimating()
        
        self.interactor?.fetchForecast14Days(id: id)
            .catchError({ [unowned self] error -> Observable<ModelListWeather?> in
                self.handleNetworkError(error)
                //self.wfVc?.displayAlert(message: error.localizedDescription)
                return Observable.just(nil)
            })
            .subscribe(onNext: { [unowned self] modelResponse in
                if let validModel = modelResponse {
                    self.dataSource = validModel
                    self.state.accept(.finished)
                    //self.vc?.showListWeatherByCountry(model: validModel)
                } else {
                    self.state.accept(.failed)
                }
            }).disposed(by: disposeBag)
    }
    
    func updateViewForecaseWeeklyDummy() {
        self.dataWeekly = self.interactor?.fetchDummyForecastWeekly(total: 16)
        if let data = self.dataWeekly {
            self.vc?.modelWeekly = data
        }
    }
    
    func updateViewForecaseHourlyDummy() {
           self.dataHourly = self.interactor?.fetchDummyForecastHourly(total: 12)
        if let data = self.dataHourly {
            self.vc?.modelHourly = data
        }
       }
}
