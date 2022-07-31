//
//  SUMCDataStore.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

@MainActor class SUMCDataStore: ObservableObject {
    
    let sumcService: SUMCServiceProtocol
    @Published private(set) var sumcData: SUMCData
    
    init(sumcService: SUMCServiceProtocol) {
        self.sumcService = sumcService
        self.sumcData = sumcService.initialData
    }
    
    var stops: [Stop] { sumcData.stops }
    var lines: [Line] { sumcData.lines }
    
    func fetchStaticData() async throws -> () {
        self.sumcData = try await self.sumcService.fetchStaticData()
    }
    
    func fetchLineSchedule(stopCode: String) async throws -> [LineSchedule] {
        return try await self.sumcService.fetchSchedule(stopCode: stopCode)
    }
    
}
