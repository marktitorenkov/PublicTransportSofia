//
//  File.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct Line: Identifiable {
    let id: LineIdentifier
    let displayName: String
    let stops: [[Stop]]
    
    init(id: LineIdentifier, displayName: String? = nil, stops: [[Stop]]) {
        self.id = id
        self.displayName = displayName ?? id.name
        self.stops = stops
    }
}
