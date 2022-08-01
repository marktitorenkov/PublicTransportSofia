//
//  LineStopsViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class LineStopsViewModel: ObservableObject {
    
    @Published var direction = 0
    
    func getDirectonStops(_ line: Line) -> [Stop] {
        return line.stops.indices.contains(direction)
        ? line.stops[direction]
        : []
    }
    
}
