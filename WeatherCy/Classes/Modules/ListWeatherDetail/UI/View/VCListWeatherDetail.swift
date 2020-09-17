//
//  VCListWeatherDetail.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class VCListWeatherDetail: UIViewController {
    @IBOutlet weak var tabelWeather: UITableView!
    
    @IBOutlet weak var imgIconNow: UIImageView!
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelNow: UILabel!
    
    var model: ModelCountryWeather?
    var eventHandler : PListWeatherDetail?
    
    var modelWeekly:[ModelWeatherDetail]? {
        didSet {
            self.tabelWeather.reloadSections(IndexSet([1]), with: .top)
        }
    }
    
    var modelHourly: [ModelWeatherDetail]? {
        didSet {
            self.tabelWeather.reloadSections(IndexSet([0]), with: .top)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        if let model = self.model {
            self.setDataToview(model: model)
            if let _ = model.id {
                //self.eventHandler?.updateViewForecastWeekly(id: id)
                self.eventHandler?.updateViewForecaseWeeklyDummy()
                self.eventHandler?.updateViewForecaseHourlyDummy()
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        let nibToRegister = UINib(nibName: String(describing: CellSectionWeekly.self), bundle: nil)
        self.tabelWeather.register(nibToRegister, forCellReuseIdentifier: String(describing: CellSectionWeekly.self))
        
        let nibToRegister2 = UINib(nibName: String(describing: CellSectionHourly.self), bundle: nil)
        self.tabelWeather.register(nibToRegister2, forCellReuseIdentifier: String(describing: CellSectionHourly.self))
        self.tabelWeather.register(TableHeaderView.nib,forHeaderFooterViewReuseIdentifier:
            TableHeaderView.reuseIdentifier)
        
        self.tabelWeather.delegate = self
        self.tabelWeather.dataSource = self
        self.tabelWeather.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tabelWeather.separatorInset = .zero
    }
}


extension VCListWeatherDetail {
    //MARK: - UI METHODS
    func setDataToview(model: ModelCountryWeather) {
        self.model = model
        self.labelCity.text = model.name
        if let str = model.main?.temp {
            self.labelNow.text = String(format: "%.01f", str).formatDegree()
        }
        
        if let str = model.weather?.first?.main {
            self.imgIconNow.image = UIImage(named: str.imageName())
        }
        
    }
    
    func setDataToTable(model: ModelCountryWeather) {
        self.model = model
        self.tabelWeather.reloadData()
        //self.loadingView.stopAnimating()
        //self.loadingView.isHidden = true
    }
}

//MARK: - TableView
extension VCListWeatherDetail: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.modelWeekly?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellSectionHourly.self)) as! CellSectionHourly
            cell.model = self.modelHourly
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellSectionWeekly.self)) as! CellSectionWeekly
            
            if let model = self.modelWeekly?[indexPath.row] {
                if let str = model.day {
                    cell.labelDay.text = str
                }
                
                if let str = model.temp_min {
                    cell.lblTempMin.text = String(format: "%.01f", str).formatDegree()
                }
                
                if let str = model.temp_max {
                    cell.labelTempMax.text = String(format: "%.01f", str).formatDegree()
                }
                
                if let str = model.name {
                    cell.imgIcon.image = UIImage(named: str.imageName())
                }
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 88
        } else {
            return 70
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Hourly"
        } else {
            return "This week"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TableHeaderView.reuseIdentifier)
            as? TableHeaderView
            else {
                return nil
        }
        
        if section == 0 {
            view.labelTitle.text = "Hourly"
        } else {
            view.labelTitle.text = "This week"
        }
        
        return view
    }
    
}
