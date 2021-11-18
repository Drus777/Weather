//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Andrey on 18.11.21.
//

import UIKit

protocol Builder {
  static func createMainModul() -> UIViewController
}

class ModuleBuilder: Builder {
  
  static func createMainModul() -> UIViewController {
    let view = MainVC()
    let networkService = NetworkService()
    let presenter = MainViewPresenter(view: view, networkService: networkService)
    view.presenter = presenter
    return view
  }
  
}
