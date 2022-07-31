//
//  SUMCServiceProtocol.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

protocol SUMCServiceProtocol {
    
    var initialData: SUMCData { get }
    
    func fetchStaticData() async throws -> SUMCData
    
    func fetchSchedule(stopCode: String) async throws -> [LineSchedule]
    
}
