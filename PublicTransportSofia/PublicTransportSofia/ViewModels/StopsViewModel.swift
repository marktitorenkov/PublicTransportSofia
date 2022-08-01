//
//  StopsViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class StopsViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    func getSearchResults(_ sumcDataStore: SUMCDataStore) -> [Stop] {
        if searchText.isEmpty {
            return sumcDataStore.stops
        } else {
            return sumcDataStore.stops.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.code.contains(searchText)
            }
        }
    }
    
}
