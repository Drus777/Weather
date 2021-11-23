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
  
  private let language = NSLocale.preferredLanguages[0]
  
  func setup(_ temperature: [HourlyWeather]){
    
    guard let temp = temperature[0].currentTemp else { return }
    
    if language == "en" {
      let pharyngates = Int(Double(temp)! * 1.8 + 32)
      temperatureLabel.text = "\(pharyngates)°"
    } else {
      temperatureLabel.text = "\(temp)°"
    }
   
  }
  
}
