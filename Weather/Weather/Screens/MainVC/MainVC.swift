
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
  private var timer: Timer?
  
  private let locationService = LocationService.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getWeatherWithLocation()
    setupItem()
    setupTableView()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 1.8, repeats: false, block: { [weak self] _ in
      if self?.presenter?.weather == nil {
        self?.setupInfoAlert()
      }
    })
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: CurrentWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: CurrentWeatherTableViewCell.cellName)
    tableView.register(UINib(nibName: HourlyWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: HourlyWeatherTableViewCell.cellName)
    tableView.register(UINib(nibName: DailyWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: DailyWeatherTableViewCell.cellName)
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  
  private func setupItem(){
    
    self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(setupAlert(param:))), animated: true)
    
  }
  
  @objc func setupAlert(param: UIBarButtonItem) {
    
    let alert = UIAlertController(title: "enter_city".localized, message: "", preferredStyle: .alert)
    
    alert.addTextField { field in
      field.placeholder = "city".localized
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
  
  private func setupInfoAlert(){
    let defaults = UserDefaults.standard
    guard let date = defaults.object(forKey: "date") as? Date else { return }
    
    let difference = Date().timeIntervalSince1970 - date.timeIntervalSince1970
    var result = ""
    if difference < 3600 {
      result = "\(Int(difference / 60)) " + "min".localized
    } else if difference < 43200 {
      result = "\(Int(difference / 3600)) " + "h".localized
    } else {
      result = "\(Int(difference / 43200)) " + "d".localized
    }
    
    let alert = UIAlertController(title: "no_internet".localized, message: "data_is_out".localized + " \(result)", preferredStyle: .alert)
    let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
      self.navigationController?.dismiss(animated: true, completion: nil)
    }
    alert.addAction(okButton)
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
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 2 {
      guard let presenter = presenter else { return 0}
      
      return presenter.dailyWeatherData.count
    }
    
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.cellName, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
      
      guard let presenter = presenter else { return UITableViewCell() }
      
      if !presenter.hourlyWeatherData.isEmpty {
        cell.setup(presenter.hourlyWeatherData)
      }
      
      return cell
      
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.cellName, for: indexPath) as? HourlyWeatherTableViewCell else { return UITableViewCell() }
      
      guard let presenter = presenter else { return UITableViewCell()}
      cell.configuration(with: presenter.hourlyWeatherData)
      return cell
      
    case 2:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.cellName, for: indexPath) as? DailyWeatherTableViewCell else { return UITableViewCell() }
      
      guard let presenter = presenter else { return UITableViewCell()}
      cell.setup(presenter.dailyWeatherData, index: indexPath.row)
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
    if indexPath.section == 2 {
      return 85
    }
    return UIScreen.main.bounds.height / 3
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 2 {
      return 10
    }
    return 0
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



