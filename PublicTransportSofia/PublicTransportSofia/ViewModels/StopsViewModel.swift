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
    
    func getSearchResults(_ sumcDataStore: SUMCDataStore, _ locationManager: LocationManager) -> [StopWithDistance] {
        if let sortFunction =  {
            return getFilteredResults(sumcDataStore)
                .map(calculateStopDistance(locationManager.lastLocation))
                .sorted(by: getSortFunction())
        }
        return []
    }
        
    private func calculateStopDistance(_ currentLocation: CLLocation?) -> ((Stop) -> StopWithDistance) {
        return { a in
            guard let currentLocation = currentLocation else {
                return StopWithDistance(stop: a, distance: nil)
            }
            
            let distance = CLLocation(latitude: a.coordinate.lat, longitude: a.coordinate.lon).distance(from: currentLocation)
            
            let stopWithDistance = StopWithDistance(stop: a, distance: distance)
            return stopWithDistance
        }
    }
    
    private func getSortFunction() -> ((StopWithDistance, StopWithDistance) -> Bool)? {
        switch sort {
        case .byLocation: return { a, b in
            if let aDistance = a.distance, let bDistance = b.distance {
                return aDistance < bDistance
            }
            return false
        }
        case .byName: return { a, b in a.stop.name.localizedCompare(b.stop.name) == .orderedAscending }
        case .byCode: return { a, b in a.stop.code.compare(b.stop.code) == .orderedAscending }
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
