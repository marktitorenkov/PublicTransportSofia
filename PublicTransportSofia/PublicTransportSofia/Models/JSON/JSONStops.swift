//
//  JSONStops.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

struct JSONStop: Decodable {
    let n: String
    let x: Double
    let y: Double
}

typealias JSONStops = [String : JSONStop]
