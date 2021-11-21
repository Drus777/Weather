//
//  WeatherResponce.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import Foundation

struct Weather: Codable {
  var icon: String?
}

struct TemperatureForDay: Codable {
  var min: Double?
  var max: Double?
}

struct CurrentWeatherForecast: Codable {
  var temp: Double?
  var weather: [Weather]?
}

struct HourlyWeatherForecast: Codable {
  var dt: Int?
  var temp: Double?
  var weather: [Weather]?
}

struct DailyWeatherForecast: Codable {
  var dt: Int?
  var temp: TemperatureForDay?
  var weather: [Weather]?
}

struct WeatherResponce: Codable {
  var current: CurrentWeatherForecast
  var hourly: [HourlyWeatherForecast]
  var daily: [DailyWeatherForecast]
}
