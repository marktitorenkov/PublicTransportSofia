//
//  FavouritesViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    
    private let favouritesService: FavouritesServiceProtocol
    @Published var stops: [Stop] = [] {
        didSet { saveFavourites() }
    }
    
    @Published var lines: [Line] = [] {
        didSet { saveFavourites() }
    }
    
    init(sumcService: SUMCServiceProtocol, favouritesService: FavouritesServiceProtocol) {
        self.favouritesService = favouritesService
        if let favourites = favouritesService.loadFavourites() {
            self.stops = favourites.stopCodes.compactMap({ code in sumcService.stops.first(where: { $0.code == code }) })
            self.lines = favourites.lineIds.compactMap({ id in sumcService.lines.first(where: { $0.id == id }) })
        }
    }
    
    func deleteStop(indexSet: IndexSet) {
        stops.remove(atOffsets: indexSet)
    }
    
    func moveStop(from: IndexSet, to: Int) {
        stops.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteLine(indexSet: IndexSet) {
        stops.remove(atOffsets: indexSet)
    }
    
    func moveLine(from: IndexSet, to: Int) {
        stops.move(fromOffsets: from, toOffset: to)
    }
    
    private func saveFavourites() {
        favouritesService.saveFavourites(favourites: Favourites(
            stopCodes: stops.map(\.code),
            lineIds: lines.map(\.id)))
    }
    
}
