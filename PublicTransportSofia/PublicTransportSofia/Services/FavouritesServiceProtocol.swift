//
//  FavouritesServiceProtocol.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

protocol FavouritesServiceProtocol {
    
    func loadFavourites() -> Favourites
    
    func saveFavourites(favourites: Favourites) -> Void
    
}
