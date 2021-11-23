//
//  MainViewPresenter.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import Foundation
import CoreData

protocol MainViewProtocol: AnyObject {
  func succes()
  func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
  var weather: WeatherResponce? { get set }
  var hourlyWeatherData: [HourlyWeather] { get set }
  var dailyWeatherData: [DailyWeather] { get set }
  
  func getWeather(lat: String, lon: String)
  init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
}

class MainViewPresenter: MainViewPresenterProtocol {
  
  weak var view: MainViewProtocol?
  
  let networkService: NetworkServiceProtocol!
  private let coreDataService = CoreDataService.shared
  
  var weather: WeatherResponce? {
    didSet {
      if weather != nil {
        deleteData()
        saveHourlyWeatherToCoreData()
        saveDailyWetaherToCoreData()
        fetchData()
      } 
    }
  }
  
  var hourlyWeatherData: [HourlyWeather] = []
  var dailyWeatherData: [DailyWeather] = []
  
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
  
  // MARK: - CoreData
  
  private func saveHourlyWeatherToCoreData(){
    for i in 0...6 {
      let hourlyWeather = HourlyWeather(moc: coreDataService.managedObjectContext)
      
      guard
        let hourlyTemp = weather?.hourly[i].temp,
        let time = weather?.hourly[i].dt,
        let icon = weather?.hourly[i].weather?[0].icon,
        let currentTemp = weather?.current.temp
      else { return }
      
      hourlyWeather?.hourlyTemp = "\(Int(hourlyTemp))"
      hourlyWeather?.time = Int64(time)
      hourlyWeather?.icon = "\(icon)"
      hourlyWeather?.currentTemp  = "\(Int(currentTemp))"
      coreDataService.saveContext()
    }
  }
  
  private func saveDailyWetaherToCoreData() {
    
    let defaults = UserDefaults.standard
    let date = Date()
    
    weather?.daily.forEach({ weather in
      let dailyWeather = DailyWeather(moc: coreDataService.managedObjectContext)
      
      guard
        let day = weather.dt,
        let icon = weather.weather?[0].icon,
        let maxTemp = weather.temp?.max,
        let minTemp = weather.temp?.min
      else { return }
      
      dailyWeather?.day = Int64(day)
      dailyWeather?.icon = icon
      dailyWeather?.maxTemp = "\(Int(maxTemp))"
      dailyWeather?.minTemp = "\(Int(minTemp))"
      
      defaults.setValue(date, forKey: "date")
      
      coreDataService.saveContext()
    })
    
  }
  
  func fetchData() {
    
    let hourlyFetchRequest: NSFetchRequest<HourlyWeather> = HourlyWeather.fetchRequest()
    let dailyFetchRequest: NSFetchRequest<DailyWeather> = DailyWeather.fetchRequest()
    do {
      let hourlyResults = try coreDataService.managedObjectContext.fetch(hourlyFetchRequest)
      let dailyResults = try coreDataService.managedObjectContext.fetch(dailyFetchRequest)
      hourlyWeatherData = hourlyResults
      dailyWeatherData = dailyResults
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func deleteData() {
    let hourlyFetchRequest: NSFetchRequest<HourlyWeather> = HourlyWeather.fetchRequest()
    let dailyFetchRequest: NSFetchRequest<DailyWeather> = DailyWeather.fetchRequest()
    
    guard
      let hourlyData = try? coreDataService.managedObjectContext.fetch(hourlyFetchRequest),
      let dailyData = try? coreDataService.managedObjectContext.fetch(dailyFetchRequest)
    else { return }
    hourlyData.forEach{ coreDataService.managedObjectContext.delete($0) }
    dailyData.forEach{ coreDataService.managedObjectContext.delete($0) }
    CoreDataService.shared.saveContext()
  }
  
}
