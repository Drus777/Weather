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
  
  func setup(_ weather: [DailyWeather], index: Int){

    guard
      let minTemp = weather[index].minTemp,
          let maxTemp = weather[index].maxTemp,
          let icon = weather[index].icon
    else { return }
    
    let date = Date(timeIntervalSince1970: TimeInterval(weather[index].day))
    let dateformater = DateFormatter()
    dateformater.dateFormat = "EE"
    let dateString = dateformater.string(from: date)
    
    dayLabel.text = dateString
    minTempLabel.text = "min: \(minTemp)°"
    maxTempLabel.text = "max: \(maxTemp)°"
    iconImageView.image = UIImage(named: icon)
    
  }
  
}
