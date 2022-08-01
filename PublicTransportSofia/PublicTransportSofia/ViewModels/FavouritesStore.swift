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
        return favourites.stopCodes.contains(where: { $0 == code })
    }
    
    func getLine(id: LineIdentifier) -> Bool {
        return favourites.lineIds.contains(where: { $0 == id })
    }
    
    func toggleStop(code: String) -> Void {
        updateStop(code: code, favourited: !getStop(code: code))
    }
    
    func toggleLine(id: LineIdentifier) -> Void {
        updateLine(id: id, favourited: !getLine(id: id))
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
    
    func updateStop(code: String, favourited: Bool) -> Void {
        favourites.stopCodes = updated(collection: favourites.stopCodes, value: code, favourited: favourited)
    }
    
    func updateLine(id: LineIdentifier, favourited: Bool) -> Void {
        favourites.lineIds = updated(collection: favourites.lineIds, value: id, favourited: favourited)
    }
    
    private func updated<T: Equatable>(collection: [T], value: T, favourited: Bool) -> [T] {
        var collectionCopy = collection
        if favourited {
            if !collectionCopy.contains(value) {
                collectionCopy.append(value)
            }
        } else {
            collectionCopy.removeAll(where: { $0 == value })
        }
        return collectionCopy
    }
    
}
