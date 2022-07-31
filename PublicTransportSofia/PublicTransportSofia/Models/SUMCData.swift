//
//  SUMCData.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

struct SUMCData {
    let lines: [Line]
    let stops: [Stop]
    
    init(stops: [Stop] = [], lines: [Line] = []) {
        self.stops = stops
        self.lines = lines
    }
}
