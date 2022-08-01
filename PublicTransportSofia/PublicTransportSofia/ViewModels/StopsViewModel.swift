//
//  StopsViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation
import CoreLocation

class StopsViewModel: ObservableObject {
    
    enum Sort {
        case byCode, byName, byLocation
    }
    
    @Published var searchText = ""
    @Published var sort = Sort.byCode
    
    func getSearchResults(_ sumcDataStore: SUMCDataStore, _ locationManager: LocationManager) -> [Stop] {
        if let sortFunction = getSortFunction(locationManager) {
            return getFilteredResults(sumcDataStore)
                .sorted(by: sortFunction)
        }
        return []
    }
    
    private func getSortFunction(_ locationManager: LocationManager) -> ((Stop, Stop) -> Bool)? {
        if sort == .byLocation {
            locationManager.startUpdatingLocation()
            if locationManager.locationStatus == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
                return nil
            } else {
                guard let currentLocation = locationManager.lastLocation else { return nil }
                let makeCLLocation = { (c: Coordinate) in CLLocation(latitude: c.lat, longitude: c.lon) }
                return { a, b in
                    let aDist = makeCLLocation(a.coordinate).distance(from: currentLocation)
                    let bDist = makeCLLocation(b.coordinate).distance(from: currentLocation)
                    return aDist < bDist
                }
            }
        } else {
            locationManager.stopUpdatingLocation()
            switch sort {
            case .byName: return { a, b in a.name.localizedCompare(b.name) == .orderedAscending }
            case .byCode: return { a, b in a.code.compare(b.code) == .orderedAscending }
            default: return nil
            }
        }
    }
    
    private func getFilteredResults(_ sumcDataStore: SUMCDataStore) -> [Stop] {
        if searchText.isEmpty {
            return sumcDataStore.stops
        } else {
            return sumcDataStore.stops.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.code.contains(searchText)
            }
        }
    }
    
}
