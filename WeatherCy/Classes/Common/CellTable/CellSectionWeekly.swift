//
//  CellSectionWeekly.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CellSectionWeekly: UITableViewCell {
    @IBOutlet weak var labelTitleMin: UILabel!
    @IBOutlet weak var lblTempMin: UILabel!
    
    @IBOutlet weak var labelTempMax: UILabel!
    @IBOutlet weak var labelTitleMax: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var labelDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
