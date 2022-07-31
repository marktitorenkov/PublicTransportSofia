//
//  LinesViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import SwiftUI

class LinesViewModel: ObservableObject {
    
    let sumcService : SUMCServiceProtocol
    @Binding var favourites: Favourites
    
    @Published var searchText = ""
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>) {
        self.sumcService = sumcService
        self._favourites = favourites
    }
    
    var searchResultsByType: [LineType : [Line]] {
        Dictionary(grouping: searchResults, by: { $0.id.type })
    }
    
    var searchResults: [Line] {
        if searchText.isEmpty {
            return sumcService.lines
        } else {
            return sumcService.lines.filter {
                $0.id.name.contains(searchText)
            }
        }
    }
}
