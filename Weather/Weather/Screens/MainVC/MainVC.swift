
//
//  ViewController.swift
//  Weather
//
//  Created by Andrey on 17.11.21.
//

import UIKit

final class MainVC: UIViewController, HourlyWeatherTableViewCellDelegate {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var presenter: MainViewPresenterProtocol!
  
  private let locationService = LocationService.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getWeatherWithLocation()
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: CurrentWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: CurrentWeatherTableViewCell.cellName)
    tableView.register(UINib(nibName: HourlyWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: HourlyWeatherTableViewCell.cellName)
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func getWeatherWithLocation() {
    let lat = locationService.lat
    let lon = locationService.lng
    presenter.getWeather(lat: "\(lat)", lon: "\(lon)")
    tableView.reloadData()
  }
  
  func getWeatherResponce() -> WeatherResponce? {
    return presenter.weather
  }
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.cellName, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
      
      if let temp = presenter.weather?.current.temp {
        cell.setup(temp)
      }
      
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.cellName, for: indexPath) as? HourlyWeatherTableViewCell else { return UITableViewCell() }
      
      cell.configuration(with: presenter.weather)
      
      return cell
    default:
      break
    }
    
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 1 {
      return UIScreen.main.bounds.height / 5
    }
    return UIScreen.main.bounds.height / 3
  }
  
}


//MARK: - MainViewProtocol
extension MainVC: MainViewProtocol {
  
  func succes() {
    tableView.reloadData()
  }
  
  func failure(error: Error) {
    print(error.localizedDescription)
  }
  
}



