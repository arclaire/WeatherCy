//
//  CellWeatherHourly.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CellWeatherHourly: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelHour: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setIconImage()
        // Initialization code
    }
    
    func setIconImage () {
        self.imgIcon.image = UIImage.init(named: "cloud.heavyrain.fill")
    }

}
