//
//  Coordinate.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct Coordinate {
    let x: Double;
    let y: Double;
    
    var lon: Double { get { return x } }
    var lat: Double { get { return y } }
}
