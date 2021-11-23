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
 
  func succes() {
    
    guard
      let presenter = presenter,
      let weather = presenter.weather,
      let main = weather.main,
      let temp = main.temp,
      let icon = weather.weather[0].icon,
      let cityName = weather.name
    else { return }
    tempLabel.text = "\(Int(temp))°"
    iconImageView.image = UIImage(named: icon)
    cityNameLabel.text = cityName
  }
  
  func failure(error: Error) {
    DispatchQueue.main.async { [weak self] in
      self?.cityNameLabel.text = "Неправильно введен город"
    }
    print(error.localizedDescription)
  }
  
}



