//
//  MainViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var sumcFetched = false
    
    func fetchSumcData(_ sumcDataStore: SUMCDataStore) async {
        try? await sumcDataStore.fetchStaticData()
        await MainActor.run {
            sumcFetched = true
        }
    }
    
}
