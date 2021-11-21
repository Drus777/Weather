//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import UIKit

protocol Builder {
  static func createMainModul() -> UIViewController
  static func createCityWeatherModul(cityName: String?) -> UIViewController
}

class ModuleBuilder: Builder {
  
  static func createMainModul() -> UIViewController {
    let view = MainVC()
    let networkService = NetworkService()
    let presenter = MainViewPresenter(view: view, networkService: networkService)
    view.presenter = presenter
    return view
  }
  
  static func createCityWeatherModul(cityName: String?) -> UIViewController {
    let view = CityWeatherVC()
    let networkService = NetworkService()
    let presenter = CityWeatherPresenter(view: view, networkService: networkService, cityName: cityName)
    view.presenter = presenter
    return view
  }
  
}
