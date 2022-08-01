//
//  SumcService.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class SumcService: SumcServiceProtocol {
    
    private let api: SumcApiServiceProtocol
    
    init(api: SumcApiServiceProtocol) {
        self.api = api
    }
    
    var initialData: SumcData {
        return SumcData()
    }
    
    func fetchStaticData() async throws -> SumcData {
        let (
            stopsJSON,
            routesJSON
        ) = await (
            try api.fetchStps(),
            try api.fetchRoutes()
        )
        
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
        
        return SumcData(stops: stops, lines: lines)
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
    
    func fetchSchedule(sumcData: SumcData, stopCode: String) async -> [LineSchedule] {
        if let schedule = try? await fetchDefaultSchedule(stopCode: stopCode) {
            return schedule
        }
        if let schedule = try? await fetchSubwaySchedule(sumcData: sumcData, stopCode: stopCode) {
            return schedule
        }
        return []
    }
    
    private func fetchDefaultSchedule(stopCode: String) async throws -> [LineSchedule] {
        let timingJSON = try await api.fetchTiming(stopCode: stopCode)
        
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
    
    private func fetchSubwaySchedule(sumcData: SumcData, stopCode: String) async throws -> [LineSchedule] {
        let subwayTimetablesJSON = try await api.fetchSubwayTimetables()
        
        let now = Date()
        let weekday = Calendar.current.component(.weekday, from: (now - 1 * 60 * 60))
        let arrivals = weekday >= 2 && weekday <= 6
        ? subwayTimetablesJSON.weekday
        : subwayTimetablesJSON.weekend
        
        let timetables = arrivals.mapValues({ lines -> [LineSchedule] in
            return lines.map({ (key, value) -> LineSchedule in
                let displayName = sumcData.lines.first(where: { $0.id.name == key })?.displayName
                return LineSchedule(
                    id: LineIdentifier(name: key, type: .metro),
                    displayName: displayName,
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
