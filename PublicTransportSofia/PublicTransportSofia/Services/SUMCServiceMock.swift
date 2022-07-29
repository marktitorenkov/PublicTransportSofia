//
//  SUMCServiceMock.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class SUMCServiceMock: SUMCServiceProtocol {
    
    func fetchStaticData() async throws {
    }
    
    func fetchSchedule(stopCode: String) async throws -> [LineSchedule] {
        [
            LineSchedule(id: LineIdentifier(name: "305", type: .bus), arrivals: [Date() + 100, Date() + 5 * 60, Date() + 15 * 60]),
            LineSchedule(id: LineIdentifier(name: "10", type: .tram), arrivals: [Date() + 50, Date() + 3 * 60]),
            LineSchedule(id: LineIdentifier(name: "15", type: .tram), arrivals: [Date() + 50, Date() + 3 * 60]),
        ]
    }
    
    var lines: [Line] {
        [
            Line(id: LineIdentifier(name: "305", type: .bus), Stops: [
                [
                    Stop(id: "0004", name: "Blok 411", coordinate: Coordinate(x: 0, y: 0)),
                    Stop(id: "0005", name: "Blok 412", coordinate: Coordinate(x: 0, y: 0)),
                    Stop(id: "0006", name: "Blok 413", coordinate: Coordinate(x: 0, y: 0)),
                ],
                [
                    Stop(id: "0007", name: "Blok 413", coordinate: Coordinate(x: 0, y: 0)),
                    Stop(id: "0008", name: "Blok 412", coordinate: Coordinate(x: 0, y: 0)),
                    Stop(id: "0009", name: "Blok 411", coordinate: Coordinate(x: 0, y: 0)),
                ]
            ]),
            Line(id: LineIdentifier(name: "213", type: .bus), Stops: []),
            Line(id: LineIdentifier(name: "10", type: .tram), Stops: []),
            Line(id: LineIdentifier(name: "4", type: .trolley), Stops: []),
            Line(id: LineIdentifier(name: "4", type: .bus), Stops: []),
        ]
    }
    
    var stops: [Stop] {
        [
            Stop(id: "2224", name: "Община младост", coordinate: Coordinate(x: 0, y: 0)),
            Stop(id: "0012", name: "Test 0012", coordinate: Coordinate(x: 1, y: 1)),
            Stop(id: "0004", name: "Test 004", coordinate: Coordinate(x: 0, y: 0)),
            Stop(id: "0005", name: "Test 005", coordinate: Coordinate(x: 0, y: 0)),
        ]
    }
    
}
