//
//  SumcApiService.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class SumcApiService: SumcApiServiceProtocol {
    
    private let routesUrl = "https://cukii.me/sumc/cache/routes.json"
    private let stopsUrl = "https://cukii.me/sumc/cache/stops-bg.json"
    
    private let subwayTimetablesUrl = "https://cukii.me/sumc/cache/subway-timetables.json"
    private let timingUrl = "https://cukii.me/sumc/api/timing/%1$@"
    
    func fetchRoutes() async throws -> JSONRoutes {
        let (routesData, _) = try await URLSession.shared.data(from: URL(string: routesUrl)!)
        return try JSONDecoder().decode(JSONRoutes.self, from: routesData)
    }
    
    func fetchStps() async throws -> JSONStops {
        let (stopsData, _) = try await URLSession.shared.data(from: URL(string: stopsUrl)!)
        return try JSONDecoder().decode(JSONStops.self, from: stopsData)
    }
    
    func fetchSubwayTimetables() async throws -> JSONSubwayTimetables {
        let (subwayTimetablesData, _) = try await URLSession.shared.data(from: URL(string: subwayTimetablesUrl)!)
        return try JSONDecoder().decode(JSONSubwayTimetables.self, from: subwayTimetablesData)
    }
    
    func fetchTiming(stopCode: String) async throws -> JSONTiming {
        let (timingData, _) = try await URLSession.shared.data(from: URL(string: String(format: timingUrl, stopCode))!)
        return try JSONDecoder().decode(JSONTiming.self, from: timingData)
    }
    
}
