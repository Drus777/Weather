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
  
//  private var weather: WeatherResponce? {
//    didSet{
//
////      if weather != nil {
////
////        let fetchRequest: NSFetchRequest<HourlyWeather> = HourlyWeather.fetchRequest()
////        if let data = try? CoreDataService.shared.managedObjectContext.fetch(fetchRequest) {
////          data.forEach{ CoreDataService.shared.managedObjectContext.delete($0) }
////          CoreDataService.shared.saveContext()
////        }
////
////        saveCurrentWetaherToCoreData()
////        saveHourlyWeatherToCoreData()
////
////      }
//
////      fetchData()
//
//    }
//  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: HourlyWeatherCollectionViewCell.cellName, bundle: nil), forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellName)
  }
  
  func configuration(with weather: [HourlyWeather]) {
    self.weatherData = weather
  }
  
  // MARK: - CoreData
  
//  private func saveHourlyWeatherToCoreData(){
//    for i in 0...6 {
//      let hourlyWeatherData = HourlyWeather(moc: CoreDataService.shared.managedObjectContext)
//      
//      guard
//        let hourlyTemp = weather?.hourly[i].temp,
//        let time = weather?.hourly[i].dt,
//        let icon = weather?.hourly[i].weather?[0].icon
//      else { return }
//      
//      hourlyWeatherData?.hourlyTemp = "\(Int(hourlyTemp))"
//      hourlyWeatherData?.time = Int64(time)
//      hourlyWeatherData?.icon = "\(icon)"
//      CoreDataService.shared.saveContext()
//    }
//  }
  
//  private func saveCurrentWetaherToCoreData() {
//    let hourlyWeatherData = HourlyWeather(moc: CoreDataService.shared.managedObjectContext)
//    
//    guard  let currentTemp = weather?.current.temp else { return }
//    hourlyWeatherData?.currentTemp = "\(Int(currentTemp))"
//    CoreDataService.shared.saveContext()
//  }
  
  
//  private func fetchData() {
//
//    let fetchRequest: NSFetchRequest<HourlyWeather> = HourlyWeather.fetchRequest()
//
//    do {
//      let results = try CoreDataService.shared.managedObjectContext.fetch(fetchRequest)
//      weatherData = results
//    } catch {
//      print(error.localizedDescription)
//    }
//  }
  
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

