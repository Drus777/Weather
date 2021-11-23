//
//  DailyWeatherTableViewCell.swift
//  Weather
//
//  Created by Andrey on 21.11.21.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var dayLabel: UILabel!
  @IBOutlet private weak var minTempLabel: UILabel!
  @IBOutlet private weak var maxTempLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!
  
  static let cellName = "DailyWeatherTableViewCell"
  
  private let language = NSLocale.preferredLanguages[0]
  
  func setup(_ weather: [DailyWeather], index: Int){

    guard
      let minTemp = weather[index].minTemp,
          let maxTemp = weather[index].maxTemp,
          let icon = weather[index].icon
    else { return }
    
    let date = Date(timeIntervalSince1970: TimeInterval(weather[index].day))
    let dateformater = DateFormatter()
    dateformater.dateFormat = "EE"
    
    if language == "en" {
      let minPharyngates = Int(Double(minTemp)! * 1.8 + 32)
      let maxPharyngates = Int(Double(maxTemp)! * 1.8 + 32)
      minTempLabel.text = "min: \(minPharyngates)°"
      maxTempLabel.text = "max: \(maxPharyngates)°"
    } else {
      
      dateformater.locale = Locale(identifier: "Ru-ru")
      minTempLabel.text = "min: \(minTemp)°"
      maxTempLabel.text = "max: \(maxTemp)°"
    }
    let dateString = dateformater.string(from: date)
    dayLabel.text = dateString
    iconImageView.image = UIImage(named: icon)
  }
  
}
