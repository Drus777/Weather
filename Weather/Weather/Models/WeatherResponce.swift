//
//  WeatherResponce.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import UIKit

struct Weather: Codable {
  var icon: String?
}

struct TemperatureForDay: Codable {
  var day: Double?
}

struct CurrentWeatherForecast: Codable {
  var temp: Double?
  var weather: [Weather]?
}

struct HourlyWeatherForecast: Codable {
  var dt: Int
  var temp: Double?
  var weather: [Weather]?
}

struct DailyWeatherForecast: Codable {
  var temp: TemperatureForDay
}

struct WeatherResponce: Codable {
  var current: CurrentWeatherForecast
  var hourly: [HourlyWeatherForecast]
  var daily: [DailyWeatherForecast]
}
