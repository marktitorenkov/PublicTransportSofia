//
//  MainViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class MainViewModel: ObservableObject {
    
    let sumcService: SUMCServiceProtocol
    let favouritesService: FavouritesServiceProtocol
    @Published var favourites: Favourites {
        didSet { favouritesService.saveFavourites(favourites: favourites) }
    }
    @Published var fetchedSumc: Bool = false
    
    init(sumcService: SUMCServiceProtocol, favouritesService: FavouritesServiceProtocol) {
        self.sumcService = sumcService
        self.favouritesService = favouritesService
        self.favourites = favouritesService.loadFavourites()
    }
    
    func fetchStaticData() async throws {
        try await sumcService.fetchStaticData()
        
        await MainActor.run {
            fetchedSumc = true
        }
    }
}
