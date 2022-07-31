//
//  StopsViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import SwiftUI

class StopsViewModel: ObservableObject {
    
    let sumcService : SUMCServiceProtocol
    @Binding var favourites: Favourites
    @Published var searchText = ""
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>) {
        self.sumcService = sumcService
        self._favourites = favourites
    }
    
    var searchResults: [Stop] {
        if searchText.isEmpty {
            return sumcService.stops
        } else {
            return sumcService.stops.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.code.contains(searchText)
            }
        }
    }
}
