//
//  FavouritesServiceMock.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class FavouritesServiceMock: FavouritesServiceProtocol {
    
    func loadFavourites() -> Favourites? {
        Favourites(stopCodes: ["0004", "0005"], lineIds: [LineIdentifier(name: "213", type: .bus)])
    }
    
    func saveFavourites(favourites: Favourites) {
    }
    
}
