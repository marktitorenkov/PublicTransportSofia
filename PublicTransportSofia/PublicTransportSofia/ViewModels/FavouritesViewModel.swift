//
//  FavouritesViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    
    func getStops(_ favouritesStore: FavouritesStore, _ sumcDataStore: SumcDataStore) -> [Stop] {
        return favouritesStore.favourites.stopCodes
            .map({ code in sumcDataStore.stops.first(where: { $0.code == code })
                ?? Stop(id: code, name: "N/A", coordinate: Coordinate()) })
    }
    
    func getLines(_ favouritesStore: FavouritesStore, _ sumcDataStore: SumcDataStore) -> [Line] {
        return favouritesStore.favourites.lineIds
            .map({ id in sumcDataStore.lines.first(where: { $0.id == id })
                ?? Line(id: id, stops: []) })
    }
    
}
