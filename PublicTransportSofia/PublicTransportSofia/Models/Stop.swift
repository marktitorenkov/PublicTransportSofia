//
//  Stop.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct Stop: Identifiable {
    let id: String
    var code: String {get { return id }}
    let name: String
    let coordinate: Coordinate;
}
