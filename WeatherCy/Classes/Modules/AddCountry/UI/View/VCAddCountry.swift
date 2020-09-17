//
//  VCAddCountry.swift
//  WeatherCy
//
//  Created by Lucy on 20/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class VCAddCountry: UIViewController {

    @IBOutlet weak var tableCity: UITableView!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var textCity: UITextField!
    
    var eventHandler : PAddCountry?
    
    var model: [ModelCountry]?
    
    var modelSearch: [ModelCountry]? {
        didSet {
            self.tableCity.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
      
        self.tableCity.delegate = self
        self.tableCity.dataSource = self
        self.tableCity.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableCity.separatorInset = .zero
        self.tableCity.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func textCityValueChanged(_ sender: Any) {
        if let txt = sender as? UITextField {
            if let str = txt.text {
                if !str.isEmpty {
                    self.modelSearch = self.eventHandler?.filterModelWith(str: str)
                }
                 
            }
        }
        
    }
    
    @IBAction func editdone(_ sender: Any) {
        
    }
    @IBAction func actionCancel(_ sender: Any) {
        self.eventHandler?.dismissView()
    }
    
}


//MARK: - TableView
extension VCAddCountry: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelSearch?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if self.modelSearch?.count ?? 0 > 0 {
            let str = self.modelSearch?[indexPath.row].name
            cell.textLabel?.text = str
        }
          
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 35
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newCountry = self.modelSearch?[indexPath.row] {
            if let id = newCountry.id {
                self.eventHandler?.selectNewCity(intID: id)
                //print("XXXID", id, newCountry.name)
            }
        }
        self.eventHandler?.dismissView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Cities"
    }
}
