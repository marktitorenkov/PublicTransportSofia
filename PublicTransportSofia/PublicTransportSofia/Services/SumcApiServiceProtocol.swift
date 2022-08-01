//
//  SumcApiServiceProtocol.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

protocol SumcApiServiceProtocol {
    
    func fetchRoutes() async throws -> JSONRoutes
    
    func fetchStps() async throws -> JSONStops
    
    func fetchSubwayTimetables() async throws -> JSONSubwayTimetables
    
    func fetchTiming(stopCode: String) async throws -> JSONTiming
    
}
