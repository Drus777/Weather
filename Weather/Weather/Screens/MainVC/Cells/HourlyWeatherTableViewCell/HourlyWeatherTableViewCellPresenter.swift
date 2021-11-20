//
//  HourlyWeatherTableViewCellPresenter.swift
//  Weather
//
//  Created by Andrey on 19.11.21.
//

import Foundation

protocol HourlyWeatherTableViewCellProtocol: AnyObject {
  func succes()
  func failure(error: Error)
}

protocol HourlyWeatherTableViewCellPresenterProtocol: AnyObject {
  var weather: WeatherResponce? { get set }
  
  func getWeather(lat: String, lon: String)
  init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
}

class MainViewPresenter: MainViewPresenterProtocol {
  
  weak var view: MainViewProtocol?
  let networkService: NetworkServiceProtocol!
  var weather: WeatherResponce?
  
  required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
    self.view = view
    self.networkService = networkService
  }
  
  func getWeather(lat: String, lon: String) {
    
    networkService.getWeather(lat: lat, lon: lon) {  [weak self] result in
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
