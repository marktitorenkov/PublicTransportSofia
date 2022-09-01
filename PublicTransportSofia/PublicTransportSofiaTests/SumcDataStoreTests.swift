//
//  SumcDataStoreTests.swift
//  PublicTransportSofiaTests
//
//  Created by Ognyan Stoimenov on 1.09.22.
//

import Foundation
import XCTest

@testable import PublicTransportSofia

class SumcDataStoreTests: XCTestCase {
    private let sumcServiceMock = SumcServiceMock()
    
    func testFetchStaticData() async throws {
        let dataStore = SumcDataStore(sumcService: sumcServiceMock)
        
        try await dataStore.fetchStaticData()
        
        let expectedStops = try await sumcServiceMock.fetchStaticData().stops
        let expectedLines = try await sumcServiceMock.fetchStaticData().lines
        XCTAssertEqual(dataStore.stops, expectedStops)
        XCTAssertEqual(dataStore.lines, expectedLines)
    }
    
    func testFetchLineSchedule() async {
        let calledTimes = sumcServiceMock.fetchScheduleCalledTimes
        let dataStore = SumcDataStore(sumcService: sumcServiceMock)
        
        _ = await dataStore.fetchLineSchedule(stopCode: "")
        
        XCTAssertEqual(sumcServiceMock.fetchScheduleCalledTimes, calledTimes + 1)
    }
    
}
