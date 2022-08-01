//
//  LinesViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class LinesViewModel: ObservableObject {
    
    struct LinesByType: Identifiable {
        let id: LineType
        let lines: [Line]
    }
    
    @Published var searchText = ""
    
    func getSearchResults(_ sumcDataStore: SUMCDataStore) -> [LinesByType] {
        Dictionary(grouping: getSearchResults(sumcDataStore), by: { $0.id.type })
            .map { (key, value) in
                LinesByType(id: key, lines: value)
            }
            .sorted { a, b in
                a.id < b.id
            }
    }
    
    private func getSearchResults(_ sumcDataStore: SUMCDataStore) -> [Line] {
        if searchText.isEmpty {
            return sumcDataStore.lines
        } else {
            return sumcDataStore.lines.filter {
                $0.id.name.contains(searchText)
            }
        }
    }
    
}
