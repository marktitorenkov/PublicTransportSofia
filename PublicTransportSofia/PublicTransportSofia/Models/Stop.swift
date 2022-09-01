//
//  Stop.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct Stop: Identifiable, Equatable {
    static func == (lhs: Stop, rhs: Stop) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.coordinate.x == rhs.coordinate.x && lhs.coordinate.y == rhs.coordinate.y
    }
    
    let id: String
    var code: String { id }
    let name: String
    let coordinate: Coordinate
}
