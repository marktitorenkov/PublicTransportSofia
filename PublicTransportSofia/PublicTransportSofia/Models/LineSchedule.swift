//
//  LineSchedule.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct LineSchedule: Identifiable, Equatable {
    let id: LineIdentifier
    var line: LineIdentifier { id }
    let displayName: String
    let arrivals: [Date]
    
    init(id: LineIdentifier, displayName: String? = nil, arrivals: [Date]) {
        self.id = id
        self.displayName = displayName ?? id.name
        self.arrivals = arrivals
    }
    
    static func == (lhs: LineSchedule, rhs: LineSchedule) -> Bool {
        let a = lhs.id == rhs.id
        let b = lhs.arrivals.elementsEqual(rhs.arrivals) { a, b in
            Calendar.current.component(.hour, from: a) == Calendar.current.component(.hour, from: b) && Calendar.current.component(.minute, from: a) == Calendar.current.component(.minute, from: b)
        }
        
        return a && b
    }
}
