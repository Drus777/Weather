//
//  MainViewPresenter.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import Foundation

protocol MainViewProtocol: AnyObject {
  func succes()
  func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
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
    
    let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&appid=8c23141abc3e7340df65c4aaf59dcdd1"
    
    networkService.load(urlString: urlString, model: WeatherResponce.self) {[weak self] result in
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
