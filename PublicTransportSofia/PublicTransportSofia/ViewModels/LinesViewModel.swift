//
//  LinesViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class LinesViewModel: ObservableObject {
    
    private let sumcService : SUMCServiceProtocol
    @Published var searchText = ""
    
    init(sumcService: SUMCServiceProtocol) {
        self.sumcService = sumcService
    }
    
    var searchResultsByType: [LineType : [Line]] {
        Dictionary(grouping: searchResults, by: { $0.id.type })
    }
    
    var searchResults: [Line] {
        if searchText.isEmpty {
            return sumcService.getLines()
        } else {
            return sumcService.getLines().filter {
                $0.id.name.contains(searchText)
            }
        }
    }
}
