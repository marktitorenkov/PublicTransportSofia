//
//  LocationManagerMock.swift
//  PublicTransportSofiaTests
//
//  Created by Ognyan Stoimenov on 1.09.22.
//

import Foundation
@testable import PublicTransportSofia
import CoreLocation

class LocationManagerMock: LocationManagerProtocol {
    var lastLocation: CLLocation?
    
    var locationStatus: CLAuthorizationStatus?
    
    var requestedLocationTimes = 0
    private var location: CLLocation?
    
    
    func setMockLocation(location: CLLocation?) {
        self.location = location
    }
    
    func requestWhenInUseAuthorization() {
        requestedLocationTimes += 1
    }
    
    func startUpdatingLocation() {
        lastLocation = location
    }
    
    func stopUpdatingLocation() {
        lastLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    
}
