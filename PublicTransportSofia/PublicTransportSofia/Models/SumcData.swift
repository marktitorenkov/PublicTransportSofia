//
//  SumcData.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import Foundation

struct SumcData {
    let stops: [Stop]
    let lines: [Line]
    
    init(stops: [Stop] = [], lines: [Line] = []) {
        self.stops = stops
        self.lines = lines
    }
}
