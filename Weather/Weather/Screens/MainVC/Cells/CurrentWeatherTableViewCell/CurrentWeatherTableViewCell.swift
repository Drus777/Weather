//
//  CurrentWeatherTableViewCell.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import UIKit

final class CurrentWeatherTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var temperatureLabel: UILabel!
  
  static let cellName = "CurrentWeatherTableViewCell"  
  
  func setup(_ temperature: [HourlyWeather]){
    
    guard let temp = temperature[0].currentTemp else { return }
    temperatureLabel.text = "\(temp)°"
  }
  
}
