//
//  FavouritesStore.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

class FavouritesStore: ObservableObject {
    
    let favouritesService: FavouritesServiceProtocol
    @Published var favourites: Favourites {
        didSet { favouritesService.saveFavourites(favourites: favourites) }
    }
    
    init(favouritesService: FavouritesServiceProtocol) {
        self.favouritesService = favouritesService
        self.favourites = favouritesService.loadFavourites()
    }
    
    func getStop(code: String) -> Bool {
        return favourites.getStop(code: code)
    }
    
    func getLine(id: LineIdentifier) -> Bool {
        return favourites.getLine(id: id)
    }
    
    func toggleStop(code: String) -> Void {
        favourites.updateStop(code: code, favourited: !favourites.getStop(code: code))
    }
    
    func toggleLine(id: LineIdentifier) -> Void {
        favourites.updateLine(id: id, favourited: !favourites.getLine(id: id))
    }
    
    func deleteStops(indexSet: IndexSet) {
        favourites.stopCodes.remove(atOffsets: indexSet)
    }
    
    func deleteLines(indexSet: IndexSet) {
        favourites.lineIds.remove(atOffsets: indexSet)
    }
    
    func moveStops(from: IndexSet, to: Int) {
        favourites.stopCodes.move(fromOffsets: from, toOffset: to)
    }
    
    func moveLines(from: IndexSet, to: Int) {
        favourites.lineIds.move(fromOffsets: from, toOffset: to)
    }
    
}
