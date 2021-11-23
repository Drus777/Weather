//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Andrey on 19.11.21.
//

import UIKit
import CoreData

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private weak var tempLabel: UILabel!
  @IBOutlet private weak var timeLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!
  
  static let cellName = "HourlyWeatherCollectionViewCell"
  
  func setup(_ weatherData: [HourlyWeather], index: Int){
  
    guard
      let temp = weatherData[index].value(forKey: "hourlyTemp"),
      let time = weatherData[index].value(forKey: "time"),
      let icon = weatherData[index].value(forKey: "icon")
    else { return }
    
    let date = Date(timeIntervalSince1970: TimeInterval(time as! Int))
    let dateformater = DateFormatter()
    dateformater.dateFormat = "HH"
    let dateString = dateformater.string(from: date)
    if let icon = icon as? String{
      iconImageView.image = UIImage(named: icon)
      tempLabel.text = "\(temp)°"
    }
    
    timeLabel.text = dateString
    
  }
  
}
