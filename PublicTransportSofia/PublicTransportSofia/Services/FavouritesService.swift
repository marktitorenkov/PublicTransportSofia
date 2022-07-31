//
//  FavouritesService.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class FavouritesService: FavouritesServiceProtocol {
    
    let defaultsFavouritesKey = "FAVOURITES"
    
    func loadFavourites() -> Favourites {
        guard
            let data = UserDefaults.standard.data(forKey: defaultsFavouritesKey),
            let favourites = try? JSONDecoder().decode(JSONFavourites.self, from: data)
        else { return Favourites(stopCodes: [], lineIds: []) }
        return Favourites(stopCodes: favourites.stopCodes, lineIds: favourites.lineIds)
    }
    
    func saveFavourites(favourites: Favourites) -> Void {
        let favouritesJSON = JSONFavourites(stopCodes: favourites.stopCodes, lineIds: favourites.lineIds)
        if let data = try? JSONEncoder().encode(favouritesJSON) {
            UserDefaults.standard.set(data, forKey: defaultsFavouritesKey)
        }
    }
    
}
