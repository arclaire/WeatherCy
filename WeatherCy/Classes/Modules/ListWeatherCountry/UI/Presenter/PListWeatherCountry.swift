//
//  PListWeatherCountry.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class PListWeatherCountry: BaseViewModel {
    var wfVc: WFListWeatherCountry?
    var interactor: IListWeatherCountry?
    var vc : VCListWeatherCountry?
 
    var dataSourceObservable = BehaviorRelay<ModelListWeather?>(value:nil)
    var dataSource: ModelListWeather? {
        get {
            return dataSourceObservable.value
        }
        set {
            dataSourceObservable.accept(newValue)
        }
    }
    
    
    func updateView() {
        self.vc?.loadingView.isHidden = false
        self.vc?.loadingView.startAnimating()
        
        self.interactor?.fetchGrouptWeather()
            .catchError({ [unowned self] error -> Observable<ModelListWeather?> in
                self.handleNetworkError(error)
                self.wfVc?.displayAlert(message: error.localizedDescription)
                return Observable.just(nil)
            })
            .subscribe(onNext: { [unowned self] modelResponse in
                if let validModel = modelResponse {
                    self.dataSource = validModel
                    self.state.accept(.finished)
                    self.vc?.showListWeatherByCountry(model: validModel)
                } else {
                    self.state.accept(.failed)
                }
            }).disposed(by: disposeBag)
    }
    
    func presentVCAddCountry() {
        self.wfVc?.presentVCAddCountry(data: (self.interactor?.modelListCountry)!)
    }
    
    func goToDetail(index: Int){
        if let data = self.dataSource {
            if let datai = data.list?[index] {
                self.wfVc?.navigateToDetail(model: datai)
            }
        }
        
    }
}
