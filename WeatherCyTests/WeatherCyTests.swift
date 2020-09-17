//
//  WeatherCyTests.swift
//  WeatherCyTests
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import XCTest
@testable import WeatherCy

class WeatherCyTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLoadDataInUserDefault() {
        let dataManager = ManagerWeatherData()
        
        let arr = dataManager.getSavedCountryID()
        if arr.count > 1 {
            XCTAssert(true, "Data available")
        } else {
            XCTFail("There always default data ")
        }
    }
    
    func testSaveToUserDefault() {
        let dataManager = ManagerWeatherData()
        let arrInt = [18918,19221,12312]
        dataManager.saveArrayOfCountryID(array: arrInt)
        
        let arrload = dataManager.getSavedCountryID()
        if arrload != arrInt {
            XCTFail("Data not saved")
        }
    }
    
    func testLoadInitialDataCity() {
        let dataManager = ManagerWeatherData()
        
        if let city = dataManager.loadJson(filename: "cities") {
            XCTAssert(city.count > 0, "JSON success")
        } else {
            XCTFail("Load JSON Failed")
        }
        
        
    }
    
    func testCallFetchListWeatherAPI() {
        let dataManager = ManagerWeatherData()
        let interactor = IListWeatherCountry(manager: dataManager)
        let presenter = PListWeatherCountry()
        presenter.interactor = interactor
        
        interactor.fetchGrouptWeather()
        .catchError({ [unowned self] error -> Observable<ModelListWeather?> in
            XCTFail("Call API got error")
            return Observable.just(nil)
        })
        .subscribe(onNext: { [unowned self] modelResponse in
            if let validModel = modelResponse {
               XCTAssert(true, "Call API success and retrieve response with valid model")
            } else {
                XCTAssert(false, "Model not retrieve")
            }
        }).disposed(by: DisposeBag())
        
    }
    
    
    
}
