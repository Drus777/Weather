//
//  ViewController.swift
//  Weather
//
//  Created by Andrey on 17.11.21.
//

import UIKit
import CoreLocation

final class MainVC: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var presenter: MainViewPresenterProtocol!
  let locationManager = CLLocationManager()
  var currentLocation: CLLocation?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLocation()
    setupTableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    getWeatherWithLocation()
  }
  
  
  
  
  private func setupTableView() {
    tableView.register(UINib(nibName: CurrentWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: CurrentWeatherTableViewCell.cellName)
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func getWeatherWithLocation() {
    guard let lat = currentLocation?.coordinate.latitude,
          let lon = currentLocation?.coordinate.longitude else { return }
    presenter.getWeather(lat: "\(lat)", lon: "\(lon)")
    tableView.reloadData()
  }
  
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.cellName, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
    
    if let temp = presenter.weather?.current.temp {
      cell.setup(temp)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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

// MARK: - Location
extension MainVC: CLLocationManagerDelegate {
  
  private func setupLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if !locations.isEmpty, currentLocation == nil {
      currentLocation = locations.first
      locationManager.stopUpdatingLocation()
    }
  }
  
}




