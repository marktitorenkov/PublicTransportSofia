//
//  StopScheduleViewModelTests.swift
//  PublicTransportSofiaTests
//
//  Created by Ognyan Stoimenov on 1.09.22.
//

import Foundation
import XCTest

@testable import PublicTransportSofia

class StopScheduleViewModelTests: XCTestCase {
    func testArrivalFormat() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let testDate = formatter.date(from: "2016/10/08 22:31")!
        
        let stopScheduleVM = StopScheduleViewModel()
        
        XCTAssertEqual(stopScheduleVM.arrivalFormat(testDate), "22:31")
    }
}
