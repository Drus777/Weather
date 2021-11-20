//
//  NetworkService.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import UIKit

//protocol NetworkServiceProtocol {
//  func getWeather(lat: String, lon: String, completion: @escaping (Result<WeatherResponce?, Error>) -> Void)
//}

protocol NetworkServiceProtocol {
  func load<T: Codable>(urlString: String, model: T.Type, completion: @escaping (Result<T?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
  
  //  func getWeather(lat: String, lon: String, completion: @escaping (Result<WeatherResponce?, Error>) -> Void) {
  //
  //    let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&appid=8c23141abc3e7340df65c4aaf59dcdd1"
  //
  //    guard let url = URL(string: urlString) else { return }
  //
  //    URLSession.shared.dataTask(with: url) { data, _, error in
  //
  //      if let data = data {
  //        do {
  //          let result = try JSONDecoder().decode(WeatherResponce.self, from: data)
  //          DispatchQueue.main.async {
  //            completion(.success(result))
  //          }
  //        }
  //        catch {
  //          completion(.failure(error))
  //        }
  //      } else if let error = error {
  //        completion(.failure(error))
  //      }
  //    }.resume()
  //
  //  }
  
  
  func load<T: Codable>(urlString: String, model: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      
      if let data = data {
        do {
          let result = try JSONDecoder().decode(model.self, from: data)
          DispatchQueue.main.async {
            completion(.success(result))
          }
        }
        catch {
          completion(.failure(error))
        }
      } else if let error = error {
        completion(.failure(error))
      }
    }.resume()
    
  }
  
}
