//
//  CityWeatherPresenter.swift
//  Weather
//
//  Created by Andrey on 20.11.21.
//

import Foundation

protocol CityWeatherProtocol: AnyObject {
  func succes()
  func failure(error: Error)
}

protocol CityWeatherPresenterProtocol: AnyObject {
  var weather: CurrentWeatherResponce? { get set }
  var cityName: String? { get set }
  
  func getWeather()
  init(view: CityWeatherProtocol, networkService: NetworkServiceProtocol, cityName: String?)
}

class CityWeatherPresenter: CityWeatherPresenterProtocol {
  
  weak var view: CityWeatherProtocol?
  let networkService: NetworkServiceProtocol!
  var weather: CurrentWeatherResponce?
  var cityName: String?
  
  required init(view: CityWeatherProtocol, networkService: NetworkServiceProtocol, cityName: String?) {
    self.view = view
    self.networkService = networkService
    self.cityName = cityName
    getWeather()
  }
  
  func getWeather() {
    
    guard let cityName = cityName else { return }
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=8c23141abc3e7340df65c4aaf59dcdd1"
    
    networkService.load(urlString: urlString, model: CurrentWeatherResponce.self) {[weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let weather):
        self.weather = weather
        self.view?.succes()
      case .failure(let error):
        self.view?.failure(error: error)
      }
      
    }

  }
  
}
