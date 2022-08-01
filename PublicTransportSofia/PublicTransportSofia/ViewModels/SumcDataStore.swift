//
//  SumcDataStore.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

class SumcDataStore: ObservableObject {
    
    let sumcService: SumcServiceProtocol
    @Published private(set) var sumcData: SumcData
    
    init(sumcService: SumcServiceProtocol) {
        self.sumcService = sumcService
        self.sumcData = sumcService.initialData
    }
    
    var stops: [Stop] { sumcData.stops }
    var lines: [Line] { sumcData.lines }
    
    func fetchStaticData() async throws -> () {
        let sumcData = try await self.sumcService.fetchStaticData()
        await MainActor.run {
            self.sumcData = sumcData
        }
    }
    
    func fetchLineSchedule(stopCode: String) async -> [LineSchedule] {
        return await self.sumcService.fetchSchedule(sumcData: sumcData, stopCode: stopCode)
    }
    
}
