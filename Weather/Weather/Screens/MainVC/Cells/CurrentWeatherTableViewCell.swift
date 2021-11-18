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
  
  func setup(_ temperature: Double){
    temperatureLabel.text = "\(temperature)"
  }
  
}
