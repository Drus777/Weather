//
//  HourlyWeatherTableViewCell.swift
//  Weather
//
//  Created by Andrey on 19.11.21.
//

import UIKit
import CoreData

class HourlyWeatherTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  static let cellName = "HourlyWeatherTableViewCell"
  
  private var weatherData: [HourlyWeather] = [] {
    didSet{
      collectionView.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: HourlyWeatherCollectionViewCell.cellName, bundle: nil), forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellName)
  }
  
  func configuration(with weather: [HourlyWeather]) {
    self.weatherData = weather
  }
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return weatherData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellName, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
 
    cell.setup(weatherData, index: indexPath.item)
    
    return cell
    
  }
  
  //MARK: - UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 4, height: UIScreen.main.bounds.height / 5)
  }
  
  
}

