//
//  SumcServiceTests.swift
//  PublicTransportSofiaTests
//
//  Created by Ognyan Stoimenov on 1.09.22.
//

import Foundation
import XCTest

@testable import PublicTransportSofia

class SumcServiceTests: XCTestCase {
    private let sumcApiMock = SumcApiServiceMock()
    var sumcService: SumcService! = nil
    
    override func setUp() {
        sumcService = SumcService(api: sumcApiMock)
    }
    
    func testFetchSchedule() async {
        let lineSchedules = await sumcService.fetchSchedule(sumcData: SumcData(), stopCode: "305")
        let expectedLineSchedule = LineSchedule(id: LineIdentifier(name: "305", type: LineType.bus), arrivals: [Date() + 100, Date() + 5 * 60, Date() + 15 * 60])
        
        XCTAssertEqual(lineSchedules[0], expectedLineSchedule)
    }
    
    func testFetchStaticData() async throws {
        let staticData = try await sumcService.fetchStaticData()
        
        let expectedStop0 = Stop(id: "0002", name: "ZZZZ 9999", coordinate: Coordinate(x: 0, y: 0))
        let expectedLine0 = Line(id: LineIdentifier(name: "4", type: .bus), displayName: "4", stops: [])
        
        XCTAssertEqual(staticData.stops[0], expectedStop0)
        XCTAssertEqual(staticData.lines[0], expectedLine0)
    }
}
