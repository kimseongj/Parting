//
//  LocationManger.swift
//  Parting
//
//  Created by 박시현 on 2023/08/17.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private var manager: CLLocationManager!
    
    private var currentLatitude: CLLocationDegrees?
    private var currentLongitude: CLLocationDegrees?
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func updateLocation() {
        manager.startUpdatingLocation()
    }
    
    func getLocation() -> CLLocation? {
        manager.startUpdatingLocation()
        guard let safeLat = currentLatitude,
              let safeLng = currentLongitude else { return nil }
        return CLLocation(latitude: safeLat, longitude: safeLng)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.manager.startUpdatingLocation()
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            self.manager.requestWhenInUseAuthorization()
        case .denied:
            print("GPS 권한 요청 거부됨")
            self.manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            self.currentLatitude = lat
            self.currentLongitude = lng
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
