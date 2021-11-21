//
//  HourlyWeatherTableViewCell.swift
//  Weather
//
//  Created by Andrey on 19.11.21.
//

import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {

  @IBOutlet private weak var collectionView: UICollectionView!
  
  static let cellName = "HourlyWeatherTableViewCell"
    
  private var weather: WeatherResponce? {
    didSet {
      collectionView.reloadData()
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: HourlyWeatherCollectionViewCell.cellName, bundle: nil), forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellName)
  }
  
  func configuration(with weather: WeatherResponce?) {
    self.weather = weather
  }
    
}

extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  //MARK: -UICollectionViewDelegate
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let weather = weather else { return 0 }
    let hourlyWeather = weather.hourly[0...6]
    return hourlyWeather.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellName, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
    
    guard let weather = weather else { return UICollectionViewCell() }
    cell.setup(weather.hourly, index: indexPath.item)
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
  }
  
 //MARK: -UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 4, height: UIScreen.main.bounds.height / 5)
  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 10
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//  }
  
}

