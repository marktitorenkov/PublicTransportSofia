//
//  StopsViewModelTests.swift
//  PublicTransportSofiaTests
//
//  Created by Ognyan Stoimenov on 1.09.22.
//

import Foundation
import XCTest

@testable import PublicTransportSofia
import CoreLocation

class StopsViewModelTests: XCTestCase {
    func testFormatDistance() {
        let stopsVM = StopsViewModel()
        
        let small = stopsVM.formatDistance(distance: 1213)
        XCTAssertEqual(small, "1.2km")
        
        let big = stopsVM.formatDistance(distance: 12134)
        XCTAssertEqual(big, "12km")
    }
    
    func testGetSearchResults() {
        let locationManagerMock = LocationManagerMock()
        let mockLocation = CLLocation(latitude: 1, longitude: 1)
        locationManagerMock.setMockLocation(location: mockLocation)
        
        let sumcDataStore = SumcDataStore(sumcService: SumcServiceMock())
       
        let stopsVM = StopsViewModel()
        stopsVM.sort = .byLocation
        let stopsWithDistance = stopsVM.getSearchResults(sumcDataStore, locationManagerMock)
        let expectedClosestStop = StopWithDistance(stop: Stop(id: "0012", name: "Test 0012", coordinate: Coordinate(x: 1, y: 1)), distance: 0.0)
        
        XCTAssertEqual(stopsWithDistance[0], expectedClosestStop)
    }
}
