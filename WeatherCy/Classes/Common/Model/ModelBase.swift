//
//  ModelBase.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

enum LoadingState : Int {
    case notLoad
    case loading
    case finished
    case failed
}


class BaseViewModel: NSObject {
    var disposeBag = DisposeBag()
    var state = BehaviorRelay<LoadingState>(value: .notLoad)
    var errorModelObservable = BehaviorRelay<ModelError?>(value: nil)
    
    var errorModel: ModelError? {
        get { return errorModelObservable.value }
        set { errorModelObservable.accept(newValue) }
    }
    
    func handleNetworkError(_ error: Error) {
        if let errorResponseModel = error as? ModelError {
            self.errorModel = errorResponseModel
        } else {
            self.errorModel = ModelError(systemError: error as NSError)
        }
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
}
