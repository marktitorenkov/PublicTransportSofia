//
//  SumcApiServiceMock.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class SumcApiServiceMock: SumcApiServiceProtocol {
    
    func fetchRoutes() async throws -> JSONRoutes {
        return JSONRoutes(
            bus: [
                "305": [
                    JSONRoutesStops(codes: ["0004", "0005", "0006"]),
                    JSONRoutesStops(codes: ["0007", "0008", "0009"]),
                ],
                "213": [],
                "4": [],
            ],
            subway: [:],
            subwayNames: [:],
            tram: [
                "10": []
            ],
            trolley: [
                "4": [],
            ])
    }
    
    func fetchStps() async throws -> JSONStops {
        return [
            "2224": JSONStop(n: "Община младост", x: 0, y: 0),
            "0012": JSONStop(n: "Test 0012", x: 0, y: 0),
            "0004": JSONStop(n: "Test 0004", x: 0, y: 0),
            "0005": JSONStop(n: "Test 0005", x: 0, y: 0),
            "0002": JSONStop(n: "ZZZZ 9999", x: 0, y: 0),
        ]
    }
    
    func fetchSubwayTimetables() async throws -> JSONSubwayTimetables {
        return JSONSubwayTimetables(
            weekday: [:],
            weekend: [:])
    }
    
    func fetchTiming(stopCode: String) async throws -> JSONTiming {
        return JSONTiming(
            lines: [
                JSONTimingLine(
                    name: "305",
                    vehicle_type: "bus",
                    arrivals: [Date() + 100, Date() + 5 * 60, Date() + 15 * 60].map(arrivalString)),
                JSONTimingLine(
                    name: "10",
                    vehicle_type: "tram",
                    arrivals: [Date() + 50, Date() + 3 * 60].map(arrivalString)),
                JSONTimingLine(
                    name: "15",
                    vehicle_type: "tram",
                    arrivals: [Date() + 50, Date() + 3 * 60].map(arrivalString)),
            ])
    }
    
    private func arrivalString(_ date: Date) -> JSONTimingArrival {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return JSONTimingArrival(time: formatter.string(from: date))
    }
    
}
