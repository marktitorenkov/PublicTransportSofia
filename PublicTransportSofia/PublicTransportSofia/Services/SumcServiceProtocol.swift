//
//  SumcServiceProtocol.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

protocol SumcServiceProtocol {
    
    var initialData: SumcData { get }
    
    func fetchStaticData() async throws -> SumcData
    
    func fetchSchedule(sumcData: SumcData, stopCode: String) async -> [LineSchedule]
    
}
