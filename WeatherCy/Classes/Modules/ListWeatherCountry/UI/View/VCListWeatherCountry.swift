//
//  VCListWeatherCountry.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class VCListWeatherCountry: UIViewController {
    
    @IBOutlet weak var tableCity: UITableView!
    @IBOutlet weak var labelWeather: UILabel!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var eventHandler : PListWeatherCountry?
    
    var model: ModelListWeather = ModelListWeather() {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.configureAddCountryButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHandler?.updateView()
    }
    
    private func setupTableView() {
        let nibToRegister = UINib(nibName: String(describing: CellSectionCountry.self), bundle: nil)
        self.tableCity.register(nibToRegister, forCellReuseIdentifier: String(describing: CellSectionCountry.self))
        self.tableCity.register(TableHeaderView.nib,forHeaderFooterViewReuseIdentifier:
            TableHeaderView.reuseIdentifier)
        self.tableCity.delegate = self
        self.tableCity.dataSource = self
        self.tableCity.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableCity.separatorInset = .zero
    }
    
    func configureAddCountryButton() {
     
        var addButton: UIBarButtonItem!
        let btn = UIButton(type: .custom)
        btn.contentMode = UIView.ContentMode.scaleToFill
        btn.setBackgroundImage(UIImage(named: "addIcon"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        //btn.setImage(UIImage(named: "cart"), for: .normal)

        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.addTarget(self, action: #selector(self.goToAddCountry), for: .touchUpInside)
       
        btn.titleLabel?.backgroundColor = UIColor.red
        btn.titleLabel?.layer.masksToBounds = true
        
        btn.titleLabel?.layer.borderWidth = 1
        btn.titleLabel?.layer.borderColor = UIColor.white.cgColor
        
        addButton = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButton(addButton, animated: true)
        
    }
    
    @objc private func goToAddCountry() {
        self.eventHandler?.presentVCAddCountry()
    }
}

extension VCListWeatherCountry {
    //MARK: - UI METHODS
    func showListWeatherByCountry(model: ModelListWeather) {
        self.model = model
        self.tableCity.reloadData()
        self.loadingView.stopAnimating()
        self.loadingView.isHidden = true
    }
}

//MARK: - TableView
extension VCListWeatherCountry: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.list?.count ?? 0//self.modelAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellSectionCountry.self)) as! CellSectionCountry
        if let model = self.model.list {
            if let str = model[indexPath.row].name {
                cell.labelCityName.text = str
            }
            
            if let str = model[indexPath.row].main?.temp {
                cell.labelTemperature.text = String(format: "%.01f", str).formatDegree()
            }
            
            if let str = model[indexPath.row].weather?.first?.main {
                cell.labelICon.image = UIImage(named: str.imageName())
            }
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventHandler?.goToDetail(index: indexPath.row)
        
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
        
        view.labelTitle.text = "Your cities"
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
