//
//  SumcServiceMock.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

class SumcServiceMock: SumcServiceProtocol {
    
    private var data = SumcData(
        stops: [
            Stop(id: "2224", name: "Община младост", coordinate: Coordinate(x: 0, y: 0)),
            Stop(id: "0012", name: "Test 0012", coordinate: Coordinate(x: 1, y: 1)),
            Stop(id: "0004", name: "Test 0004", coordinate: Coordinate(x: 0, y: 0)),
            Stop(id: "0005", name: "Test 0005", coordinate: Coordinate(x: 0, y: 0)),
            Stop(id: "0002", name: "ZZZZ 9999", coordinate: Coordinate(x: 0, y: 0)),
        ],
        lines: [
            Line(id: LineIdentifier(name: "305", type: .bus), stops: [
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
            Line(id: LineIdentifier(name: "213", type: .bus), stops: []),
            Line(id: LineIdentifier(name: "10", type: .tram), stops: []),
            Line(id: LineIdentifier(name: "4", type: .trolley), stops: []),
            Line(id: LineIdentifier(name: "4", type: .bus), stops: []),
        ])
    
    var initialData: SumcData { self.data }
    
    func fetchStaticData() async throws -> SumcData { self.data }
    
    func fetchSchedule(sumcData: SumcData, stopCode: String) async -> [LineSchedule] {
        [
            LineSchedule(id: LineIdentifier(name: "305", type: .bus), arrivals: [Date() + 100, Date() + 5 * 60, Date() + 15 * 60]),
            LineSchedule(id: LineIdentifier(name: "10", type: .tram), arrivals: [Date() + 50, Date() + 3 * 60]),
            LineSchedule(id: LineIdentifier(name: "15", type: .tram), arrivals: [Date() + 50, Date() + 3 * 60]),
        ]
    }
    
}
