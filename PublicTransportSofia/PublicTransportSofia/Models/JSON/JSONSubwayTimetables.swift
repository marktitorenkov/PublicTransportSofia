//
//  JSONSubwayTimetables.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

typealias JSONSubwayTimetablesArrivals = [String : [String : [String]]]

struct JSONSubwayTimetables: Decodable {
    let weekday: JSONSubwayTimetablesArrivals
    let weekend: JSONSubwayTimetablesArrivals
}
