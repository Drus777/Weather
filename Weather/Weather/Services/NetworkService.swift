//
//  NetworkService.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import UIKit

protocol NetworkServiceProtocol {
  func load<T: Codable>(urlString: String, model: T.Type, completion: @escaping (Result<T?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
  
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
