//
//  LocationService.swift
//  Weather
//
//  Created by Andrey on 20.11.21.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
  static let shared = LocationService()
  
  private let locationManager = CLLocationManager()
  private var currentLocation: CLLocation?
  
  var lat: Double {
    currentLocation?.coordinate.latitude ?? 0
  }
  
  var lng: Double {
    currentLocation?.coordinate.longitude ?? 0
  }
  
  override init() {
    super.init()
    setupLocation()
  }
  
  func start() {
    locationManager.startUpdatingLocation()
  }
  
  func stop() {
    locationManager.stopUpdatingLocation()
  }
  
  private func setupLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
  }
}

extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if !locations.isEmpty, currentLocation == nil {
      currentLocation = locations.first
      stop()
    }
  }
}
