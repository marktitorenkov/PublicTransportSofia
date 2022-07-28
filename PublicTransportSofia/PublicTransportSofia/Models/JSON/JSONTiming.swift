//
//  JSONTiming.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

struct JSONTimingArrival: Decodable {
    let time: String
}

struct JSONTimingLine: Decodable {
    let name: String
    let vehicle_type: String
    let arrivals: [JSONTimingArrival]
}

struct JSONTiming: Decodable {
    let lines: [JSONTimingLine]
}
