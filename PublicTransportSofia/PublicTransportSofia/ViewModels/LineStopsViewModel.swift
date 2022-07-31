//
//  LineStopsViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 30.07.22.
//

import SwiftUI

class LineStopsViewModel: ObservableObject {
    
    @Binding var favourites: Favourites
    let sumcService: SUMCServiceProtocol
    let line: Line
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>, line: Line) {
        self.sumcService = sumcService
        self._favourites = favourites
        self.line = line
    }
    
    @State var direction = 0
    var directonStops: [Stop] {
        return line.stops.indices.contains(direction)
        ? line.stops[direction]
        : []
    }
    
}
