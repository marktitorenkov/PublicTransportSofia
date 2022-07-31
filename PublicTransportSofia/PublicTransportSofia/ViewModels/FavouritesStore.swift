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
}
