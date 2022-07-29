//
//  FavouritesService.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class FavouritesService: FavouritesServiceProtocol {
    
    let defaultsFavouritesKey = "FAVOURITES"
    
    func loadFavourites() -> Favourites? {
        guard
            let data = UserDefaults.standard.data(forKey: defaultsFavouritesKey),
            let favourites = try? JSONDecoder().decode(Favourites.self, from: data)
        else { return nil }
        return favourites
    }
    
    func saveFavourites(favourites: Favourites) -> Void {
        if let data = try? JSONEncoder().encode(favourites) {
            UserDefaults.standard.set(data, forKey: defaultsFavouritesKey)
        }
    }
    
}
