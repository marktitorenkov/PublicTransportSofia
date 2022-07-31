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
    
    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    var lon: Double { x }
    var lat: Double { y }
}
