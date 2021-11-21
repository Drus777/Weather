//
//  CurrentWeatherResponce.swift
//  Weather
//
//  Created by Andrey on 20.11.21.
//

import Foundation

struct WeatherInfo: Codable {
  var icon: String?
}

struct Main: Codable {
  var temp: Double?
}

struct CurrentWeatherResponce: Codable {
  var weather: [WeatherInfo]
  var main: Main?
  var name: String?
}
