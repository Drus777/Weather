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
  
  private let language = NSLocale.preferredLanguages[0]
  
  func setup(_ weatherData: [HourlyWeather], index: Int){
  
    guard
      let temp = weatherData[index].hourlyTemp,
      let time = weatherData[index].value(forKey: "time"),
      let icon = weatherData[index].value(forKey: "icon")
    else { return }
    
    let date = Date(timeIntervalSince1970: TimeInterval(time as! Int))
    let dateformater = DateFormatter()
    dateformater.dateFormat = "HH"
    let dateString = dateformater.string(from: date)
    if let icon = icon as? String{
      iconImageView.image = UIImage(named: icon)
      if language == "en" {
        let pharyngates = Int(Double(temp)! * 1.8 + 32)
        tempLabel.text = "\(pharyngates)°"
      } else {
        tempLabel.text = "\(temp)°"
      }
      
    }
    
    timeLabel.text = dateString
    
  }
  
}
