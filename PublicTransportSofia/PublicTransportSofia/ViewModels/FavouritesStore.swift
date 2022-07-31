//
//  FavouritesStore.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

@MainActor class FavouritesStore: ObservableObject {
    
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
    
    func updateStop(code: String, favourited: Bool) -> Void {
        favourites.updateStop(code: code, favourited: favourited)
    }
    
    func updateLine(id: LineIdentifier, favourited: Bool) -> Void {
        favourites.updateLine(id: id, favourited: favourited)
    }
    
    func toggleStop(code: String) -> Void {
        updateStop(code: code, favourited: !getStop(code: code))
    }
    
    func toggleLine(id: LineIdentifier) -> Void {
        updateLine(id: id, favourited: !getLine(id: id))
    }
    
}
