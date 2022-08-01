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
    
    func formatDistance(distance: Double) -> String {
        if (distance > 10_000) {
            return String(format: "%.0fkm", distance / 1000)
        }
        if (distance > 1000) {
            return String(format: "%.1fkm", distance / 1000)
        }
        return String(format: "%.0fm", distance)
    }
    
    func getSearchResults(_ sumcDataStore: SumcDataStore, _ locationManager: LocationManager) -> [StopWithDistance] {
        let location = tryGetLocation(locationManager)
        if sort == .byLocation && location == nil {
            return []
        }
        return getFilteredResults(sumcDataStore)
            .map(getTransformFunction(location))
            .sorted(by: getSortFunction())
    }
    
    func tryGetLocation(_ locationManager: LocationManager) -> CLLocation? {
        if sort == .byLocation {
            locationManager.startUpdatingLocation()
            if locationManager.locationStatus == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else {
                return locationManager.lastLocation
            }
        } else {
            locationManager.stopUpdatingLocation()
        }
        return nil
    }
    
    private func getTransformFunction(_ currentLocation: CLLocation?) -> ((Stop) -> StopWithDistance) {
        return { stop in
            let getDistance = { () -> Double in
                guard let currentLocation = currentLocation else {
                    return 0
                }
                return CLLocation(latitude: stop.coordinate.lat, longitude: stop.coordinate.lon).distance(from: currentLocation)
            }
            return StopWithDistance(stop: stop, distance: getDistance())
        }
    }
    
    private func getSortFunction() -> ((StopWithDistance, StopWithDistance) -> Bool) {
        switch sort {
        case .byCode: return { a, b in a.stop.code.compare(b.stop.code) == .orderedAscending }
        case .byName: return { a, b in a.stop.name.localizedCompare(b.stop.name) == .orderedAscending }
        case .byLocation: return { a, b in a.distance < b.distance }
        }
    }
    
    private func getFilteredResults(_ sumcDataStore: SumcDataStore) -> [Stop] {
        if searchText.isEmpty {
            return sumcDataStore.stops
        } else {
            return sumcDataStore.stops.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.code.contains(searchText)
            }
        }
    }
    
}
