//
//  LineSchedule.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct LineSchedule: Identifiable {
    let id: LineIdentifier
    var line: LineIdentifier { id }
    let displayName: String
    let arrivals: [Date]
    
    init(id: LineIdentifier, displayName: String? = nil, arrivals: [Date]) {
        self.id = id
        self.displayName = displayName ?? id.name
        self.arrivals = arrivals
    }
}
