//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 29.07.22.
//

import Foundation

class StopScheduleViewModel: ObservableObject {
    @Published var lineSchedules: [LineSchedule] = []
    
    private let sumcService : SUMCServiceProtocol
    
    init(sumcService: SUMCServiceProtocol) {
        self.sumcService = sumcService
    }
    
    func fetchLineSchedule(stopCode: String) async throws {
        let fetched = try await sumcService.fetchSchedule(stopCode: stopCode)
        
        await MainActor.run {
            lineSchedules = fetched
        }
    }
}