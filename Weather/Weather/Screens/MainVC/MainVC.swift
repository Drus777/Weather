
//
//  ViewController.swift
//  Weather
//
//  Created by Andrey on 17.11.21.
//

import UIKit

final class MainVC: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var presenter: MainViewPresenterProtocol?
  
  private let locationService = LocationService.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getWeatherWithLocation()
    setupItem()
    setupTableView()
    
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: CurrentWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: CurrentWeatherTableViewCell.cellName)
    tableView.register(UINib(nibName: HourlyWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: HourlyWeatherTableViewCell.cellName)
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  
  private func setupItem(){
    
    self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(setupAlert(param:))), animated: true)
    
  }
  
  @objc func setupAlert(param: UIBarButtonItem) {
    
    let alert = UIAlertController(title: "Введите город", message: "", preferredStyle: .alert)
    
    alert.addTextField { field in
      field.placeholder = "Город"
      field.returnKeyType = .continue
      field.keyboardType = .default
    }
    
    let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
      
      guard let fields = alert.textFields, fields.count == 1 else { return }
      let field = fields[0]
      guard let cityField = field.text, !cityField.isEmpty else { return }
     
      let nextVC = ModuleBuilder.createCityWeatherModul(cityName: cityField)
      self.navigationController?.pushViewController(nextVC, animated: true)
     
    }
    let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
      self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    alert.addAction(okButton)
    alert.addAction(cancelButton)
    navigationController?.present(alert, animated: true, completion: nil)
  }
  
  func getWeatherWithLocation() {
    let lat = locationService.lat
    let lon = locationService.lng
    presenter?.getWeather(lat: "\(lat)", lon: "\(lon)")
    tableView.reloadData()
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
      
      if let temp = presenter?.weather?.current.temp {
        cell.setup(temp)
      }
      
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.cellName, for: indexPath) as? HourlyWeatherTableViewCell else { return UITableViewCell() }
      
      cell.configuration(with: presenter?.weather)
      
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



