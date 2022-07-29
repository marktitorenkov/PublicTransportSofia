//
//  MainViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private let sumcService : SUMCServiceProtocol
    @Published var fetchedSumc: Bool = false
    
    init(sumcService: SUMCServiceProtocol) {
        self.sumcService = sumcService
    }
    
    func fetchStaticData() async throws {
        try await sumcService.fetchStaticData()
        
        await MainActor.run {
            fetchedSumc = true
        }
    }
}
