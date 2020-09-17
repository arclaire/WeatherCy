//
//  CellSectionHourly.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CellSectionHourly: UITableViewCell {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionview: UICollectionView!
    
    var model: [ModelWeatherDetail]? {
        didSet {
            self.collectionview.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpCollectionView() {
        
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.collectionview.showsHorizontalScrollIndicator = false
        self.collectionview.showsVerticalScrollIndicator = false
        self.collectionview.backgroundColor = UIColor.white
     
        self.flowLayout.minimumInteritemSpacing = 5
        self.flowLayout.minimumLineSpacing = 5
        //self.collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let nib = UINib(nibName: String(describing: CellWeatherHourly.self), bundle: nil)
        self.collectionview.register(nib, forCellWithReuseIdentifier: String(describing: CellWeatherHourly.self))
    }
}


//MARK: - COLLECTION VIEW DATA SOURCE DELEGATE
extension CellSectionHourly: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("select index", indexPath.row)
        //self.currentSelectedRow = indexPath.row
    }
}

extension CellSectionHourly: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.model {
            return model.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellWeatherHourly.self), for: indexPath) as! CellWeatherHourly
        
        if let model = self.model?[indexPath.row] {
            if let str = model.date {
                cell.labelHour.text = str
            }
            
            if let str = model.temp {
                cell.labelTemperature.text = String(format: "%.01f", str).formatDegree()
            }
            
            if let str = model.name {
                cell.imgIcon.image = UIImage(named: str.imageName())
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
