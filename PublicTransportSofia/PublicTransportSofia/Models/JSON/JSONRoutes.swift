//
//  File.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

struct JSONRoutesStops: Decodable {
    let codes: [String]
}

struct JSONRoutes: Decodable {
    let bus: [String: [JSONRoutesStops]]
    let subway: [String: [JSONRoutesStops]]
    let subwayNames: [String : String]
    let tram: [String: [JSONRoutesStops]]
    let trolley: [String: [JSONRoutesStops]]
}
