//
//  WeatherCell.swift
//  Rain or Shine
//
//  Created by Brandon Byrne on 2016-11-30.
//  Copyright © 2016 ZeahSoft. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "Low     \(forecast.lowTemp)"
        highTemp.text = "High     \(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
  

}
