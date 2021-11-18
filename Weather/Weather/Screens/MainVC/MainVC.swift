//
//  ViewController.swift
//  Weather
//
//  Created by Andrey on 17.11.21.
//

import UIKit

final class MainVC: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var presenter: MainViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: CurrentWeatherTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: CurrentWeatherTableViewCell.cellName)
    
    tableView.dataSource = self
    tableView.delegate = self
    
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

extension MainVC: MainViewProtocol {
  
  func succes() {
    tableView.reloadData()
  }
  
  func failure(error: Error) {
    print(error.localizedDescription)
  }
  
}

