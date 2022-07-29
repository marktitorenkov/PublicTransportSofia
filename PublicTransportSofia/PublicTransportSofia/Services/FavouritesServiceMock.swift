//
//  FavouritesServiceMock.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class FavouritesServiceMock: FavouritesServiceProtocol {
    
    private var favourites: Favourites?
    
    init() {
        self.favourites = Favourites(
            stopCodes: ["0004", "0005"],
            lineIds: [LineIdentifier(name: "213", type: .bus)])
    }
    
    func loadFavourites() -> Favourites? {
        return favourites
    }
    
    func saveFavourites(favourites: Favourites) {
        self.favourites = favourites
    }
    
}
