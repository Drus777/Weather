//
//  CityWeatherVC.swift
//  Weather
//
//  Created by Andrey on 20.11.21.
//

import UIKit

class CityWeatherVC: UIViewController, CityWeatherProtocol {
  
  @IBOutlet private weak var tempLabel: UILabel!
  @IBOutlet private weak var cityNameLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!
  
  var presenter: CityWeatherPresenterProtocol?
  
  private let language = NSLocale.preferredLanguages[0]
 
  func succes() {
    
    guard
      let presenter = presenter,
      let weather = presenter.weather,
      let main = weather.main,
      let temp = main.temp,
      let icon = weather.weather[0].icon,
      let cityName = weather.name
    else { return }
    
    if language == "en" {
      let pharyngates = temp * 1.8 + 32
      tempLabel.text = "\(pharyngates)°"
    }
    
    tempLabel.text = "\(Int(temp))°"
    iconImageView.image = UIImage(named: icon)
    cityNameLabel.text = cityName
  }
  
  func failure(error: Error) {
    DispatchQueue.main.async { [weak self] in
      self?.cityNameLabel.text = "city_entered_incorreclty".localized
    }
    print(error.localizedDescription)
  }
  
}



