//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Andrey on 19.11.21.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private weak var tempLabel: UILabel!
  @IBOutlet private weak var timeLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!
  
  static let cellName = "HourlyWeatherCollectionViewCell"
  
  
  func setup(_ weather: [HourlyWeatherForecast], index: Int){
    let hourlyWeather = weather[0...6]
    let date = Date(timeIntervalSince1970: TimeInterval(hourlyWeather[index].dt))
    let dateformater = DateFormatter()
    dateformater.dateFormat = "HH"
    let dateString = dateformater.string(from: date)
    
    guard
      let temp = weather[index].temp,
      let weatherInfo = weather[index].weather,
      let icon =  weatherInfo[0].icon
    else { return }
    
    timeLabel.text = dateString
    tempLabel.text = "\(Int(temp))°"
    iconImageView.image = UIImage(named: icon)
  }
  
  
  
}
