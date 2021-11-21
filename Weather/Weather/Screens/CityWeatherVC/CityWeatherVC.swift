//
//  CityWeatherVC.swift
//  Weather
//
//  Created by Andrey on 20.11.21.
//

import UIKit

class CityWeatherVC: UIViewController, CityWeatherProtocol {
  
  @IBOutlet private weak var tempLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!
  
  var presenter: CityWeatherPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
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
    self.navigationItem.title = cityName
  }
  
  func failure(error: Error) {
    DispatchQueue.main.async { [weak self] in
      self?.tempLabel.text = "Неправильно введен город"
    }
    print(error.localizedDescription)
  }
  
  
  
}



