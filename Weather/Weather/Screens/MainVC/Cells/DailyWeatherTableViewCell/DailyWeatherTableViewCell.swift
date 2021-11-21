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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setup(_ weather: WeatherResponce?, index: Int){
    guard
          let weather = weather,
          let day = weather.daily[index].dt,
          let temp = weather.daily[index].temp,
          let minTemp = temp.min,
          let maxTemp = temp.max,
          let icon = weather.daily[index].weather?[0].icon
    else { return }
    
    let date = Date(timeIntervalSince1970: TimeInterval(day))
    let dateformater = DateFormatter()
    dateformater.dateFormat = "EE"
    let dateString = dateformater.string(from: date)
    
    dayLabel.text = dateString
    minTempLabel.text = "min: \(Int(minTemp))°"
    maxTempLabel.text = "max: \(Int(maxTemp))°"
    iconImageView.image = UIImage(named: icon)
    
  }
  
}
