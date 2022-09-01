//
//  LocationManagerProtocol.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 1.09.22.
//
import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var lastLocation: CLLocation? { get }
    var locationStatus: CLAuthorizationStatus? { get }
    
    func requestWhenInUseAuthorization()
    
    func startUpdatingLocation()
    
    func stopUpdatingLocation()
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
}
