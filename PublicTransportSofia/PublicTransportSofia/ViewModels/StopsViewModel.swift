//
//  StopsViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class StopsViewModel: ObservableObject {
    
    private let sumcService : SUMCServiceProtocol
    @Published var searchText = ""
    
    init(sumcService: SUMCServiceProtocol) {
        self.sumcService = sumcService
    }
    
    var searchResults: [Stop] {
        if searchText.isEmpty {
            return sumcService.getStops()
        } else {
            return sumcService.getStops().filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.code.contains(searchText)
            }
        }
    }
}
