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
    
    var initialData: SUMCData { SUMCData() }
    
    func fetchStaticData() async throws -> SUMCData {
        async let (stopsDataAsync, _) = URLSession.shared.data(from: URL(string: stopsUrl)!)
        async let (routesDataAsync, _) = URLSession.shared.data(from: URL(string: routesUrl)!)
        
        let (stopsData, routesData) = await (try stopsDataAsync, try routesDataAsync)
        let routesJSON = try JSONDecoder().decode(JSONRoutes.self, from: routesData)
        let stopsJSON = try JSONDecoder().decode(JSONStops.self, from: stopsData)
        
        var stopsDict: [String : Stop] = [:]
        for (code, stopJSON) in stopsJSON {
            let name = stopJSON.n
                .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            stopsDict[code] = Stop(id: code, name: name, coordinate: Coordinate(x: stopJSON.x, y: stopJSON.y))
        }
        let stops = stopsDict.values.sorted(by: { $0.code.localizedStandardCompare($1.code) == .orderedAscending })
        
        var lines: [Line] = []
        lines.append(contentsOf: createLinesForType(routes: routesJSON.bus, type: .bus, stops: stopsDict))
        lines.append(contentsOf: createLinesForType(routes: routesJSON.subway, type: .metro, stops: stopsDict, nameMapping: routesJSON.subwayNames))
        lines.append(contentsOf: createLinesForType(routes: routesJSON.tram, type: .tram, stops: stopsDict))
        lines.append(contentsOf: createLinesForType(routes: routesJSON.trolley, type: .trolley, stops: stopsDict))
        
        return SUMCData(stops: stops, lines: lines)
    }
    
    private func createLinesForType(routes: [String: [JSONRoutesStops]], type: LineType, stops: [String : Stop], nameMapping: [String : String]? = nil) -> [Line] {
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
            lines.append(createLine(id: LineIdentifier(name: lineName, type: type), directions: directions, nameMapping: nameMapping))
        }
        return lines.sorted(by: { $0.id.name.localizedStandardCompare($1.id.name) == .orderedAscending })
    }
    
    private func createLine(id: LineIdentifier, directions: [[Stop]], nameMapping: [String : String]? = nil) -> Line {
        if let nameMapping = nameMapping {
            return Line(id: id, displayName: nameMapping[id.name], stops: directions)
        } else {
            return Line(id: id, stops: directions)
        }
    }
    
    func fetchSchedule(stopCode: String) async -> [LineSchedule] {
        if let schedule = try? await fetchDefaultSchedule(stopCode: stopCode) {
            return schedule
        }
        if let schedule = try? await fetchSubwaySchedule(stopCode: stopCode) {
            return schedule
        }
        return []
    }
    
    private func fetchDefaultSchedule(stopCode: String) async throws -> [LineSchedule] {
        let (timingData, _) = try await URLSession.shared.data(from: URL(string: String(format: timingUrl, stopCode))!)
        let timingJSON = try JSONDecoder().decode(JSONTiming.self, from: timingData)
        
        var lineSchedules: [LineSchedule] = []
        for lineJSON in timingJSON.lines {
            var arrivals: [Date] = []
            for arrivalJSON in lineJSON.arrivals {
                if let date = createArrivalDate(arrivalString: arrivalJSON.time) {
                    arrivals.append(date)
                }
            }
            let lineIdentifier = LineIdentifier(name: lineJSON.name, type: LineType(rawValue: lineJSON.vehicle_type)!)
            lineSchedules.append(LineSchedule(id: lineIdentifier, arrivals: arrivals))
        }
        return lineSchedules
    }
    
    private func fetchSubwaySchedule(stopCode: String) async throws -> [LineSchedule] {
        let (subwayTimetablesData, _) = try await URLSession.shared.data(from: URL(string: subwayTimetablesUrl)!)
        let subwayTimetablesJSON = try JSONDecoder().decode(JSONSubwayTimetables.self, from: subwayTimetablesData)
        
        let now = Date()
        let weekday = Calendar.current.component(.weekday, from: (now - 1 * 60 * 60))
        let arrivals = weekday >= 2 && weekday <= 6
        ? subwayTimetablesJSON.weekday
        : subwayTimetablesJSON.weekend
        
        let timetables = arrivals.mapValues({ lines in
            return lines.map({ (key, value) in
                return LineSchedule(
                    id: LineIdentifier(name: key, type: .metro),
                    arrivals: value
                        .compactMap({ createArrivalDate(arrivalString: $0) })
                        .filter({ $0 > now && $0 < now + 1 * 60 * 60 }))
            })
            .filter({ !$0.arrivals.isEmpty })
        })
        
        if let schedule = timetables[stopCode] {
            return schedule
        }
        return []
    }
    
    private func createArrivalDate(arrivalString: String) -> Date? {
        let formatter = DateFormatter()
        var arrivalTime: Date? = nil
        
        if arrivalTime == nil {
            formatter.dateFormat = "HH:mm:ss"
            arrivalTime = formatter.date(from: arrivalString)
        }
        if arrivalTime == nil {
            formatter.dateFormat = "HH:mm"
            arrivalTime = formatter.date(from: arrivalString)
        }
        
        guard let arrivalTime = arrivalTime else { return nil }
        let now = Date()
        var nowComponents = Calendar.current.dateComponents([.year, .month, .day], from: now)
        let arrivalComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: arrivalTime)
        nowComponents.hour = arrivalComponents.hour
        nowComponents.minute = arrivalComponents.minute
        nowComponents.second = arrivalComponents.second
        let arrivalDate = Calendar.current.date(from: nowComponents)!
        if (now > arrivalDate + 12 * 60 * 60) {
            return arrivalDate + 24 * 60 * 60
        }
        return arrivalDate
    }
    
}
