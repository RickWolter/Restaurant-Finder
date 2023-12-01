//
//  LocationManager.swift
//  AllTrails
//
//  Created by Rick W. on 11/19/23.
//

import UIKit
import CoreLocation
import Observation

@Observable
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
  
  var authorizationStatus: CLAuthorizationStatus = .notDetermined
  var location: CLLocationCoordinate2D?
  var manager = CLLocationManager()
  
  override init() {
    super.init()
    authorizationStatus = manager.authorizationStatus
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    
    
    
  }
  func getLatestCoordinates() async -> CLLocationCoordinate2D {
    location = manager.location?.coordinate
    return location ?? CLLocationCoordinate2D(latitude: 28.612219, longitude: -80.8076)
    
    
  }
  func requestLocation()   {
    manager.requestLocation()
    location = manager.location?.coordinate
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
    location = locations.first?.coordinate
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error getting location:: \(error.localizedDescription)")
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    authorizationStatus = manager.authorizationStatus
    switch manager.authorizationStatus {
      
    case .authorizedWhenInUse:
      authorizationStatus = .authorizedWhenInUse
      manager.requestLocation()
      break
      
    case .restricted, .denied:
      break
      
    case .notDetermined:
      authorizationStatus = .notDetermined
      manager.requestWhenInUseAuthorization()
      break
      
    default:
      break
    }
  }
}
