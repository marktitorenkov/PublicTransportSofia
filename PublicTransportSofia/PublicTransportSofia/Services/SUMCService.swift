//
//  SUMCService.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class SUMCService: SUMCServiceProtocol {
    
    private let routesUrl = "https://cukii.me/sumc/cache/routes.json"
    private let stopsUrl = "https://cukii.me/sumc/cache/stops-bg.json"
    
    private let subwayTimetablesUrl = "https://cukii.me/sumc/cache/subway-timetables.json"
    private let timingUrl = "https://cukii.me/sumc/api/timing/%1$@"
    
    private var lines: [Line] = []
    private var stops: [Stop] = []
    
    func fetchStaticData() async throws -> () {
        async let (stopsDataAsync, _) = URLSession.shared.data(from: URL(string: stopsUrl)!)
        async let (routesDataAsync, _) = URLSession.shared.data(from: URL(string: routesUrl)!)
        
        let (stopsData, routesData) = await (try stopsDataAsync, try routesDataAsync)
        let routesJSON = try JSONDecoder().decode(JSONRoutes.self, from: routesData)
        let stopsJSON = try JSONDecoder().decode(JSONStops.self, from: stopsData)
        
        var stops: [String : Stop] = [:]
        for (code, stopJSON) in stopsJSON {
            stops[code] = Stop(id: code, name: stopJSON.n, coordinate: Coordinate(x: stopJSON.x, y: stopJSON.y))
        }
        self.stops = stops.values.sorted(by: { $0.code.localizedStandardCompare($1.code) == .orderedAscending })
        
        var lines: [Line] = []
        lines.append(contentsOf: createLinesForType(routes: routesJSON.bus, type: .bus, stops: stops))
        lines.append(contentsOf: createLinesForType(routes: routesJSON.subway, type: .metro, stops: stops))
        lines.append(contentsOf: createLinesForType(routes: routesJSON.tram, type: .tram, stops: stops))
        lines.append(contentsOf: createLinesForType(routes: routesJSON.trolley, type: .trolley, stops: stops))
        self.lines = lines
    }
    
    private func createLinesForType(routes: [String: [JSONRoutesStops]], type: LineType, stops: [String : Stop]) -> [Line] {
        var lines: [Line] = []
        for (lineName, directionsJSON) in routes {
            var directions: [[Stop]] = []
            for directionJSON in directionsJSON {
                var direction: [Stop] = []
                for code in directionJSON.codes {
                    if let stop = stops[code] {
                        direction.append(stop)
                    }
                }
                directions.append(direction)
            }
            lines.append(Line(id: LineIdentifier(name: lineName, type: type), Stops: directions))
        }
        return lines.sorted(by: { $0.id.name.localizedStandardCompare($1.id.name) == .orderedAscending })
    }
    
    func fetchSchedule(stopCode: String) async throws -> [LineSchedule] {
        let (timingData, _) = try await URLSession.shared.data(from: URL(string: String(format: timingUrl, stopCode))!)
        let timingJSON = try JSONDecoder().decode(JSONTiming.self, from: timingData)
        
        var lineSchedules: [LineSchedule] = []
        for lineJSON in timingJSON.lines {
            var arrivals: [Date] = []
            for arrivalJSON in lineJSON.arrivals {
                arrivals.append(DateFormatter().date(from: arrivalJSON.time)!)
            }
            lineSchedules.append(LineSchedule(id: LineIdentifier(name: lineJSON.name, type: LineType(rawValue: lineJSON.vehicle_type)!), arrivals: arrivals))
        }
        return lineSchedules
    }
    
    func getLines() -> [Line] {
        return lines
    }
    
    func getStops() -> [Stop] {
        return stops
    }
    
}