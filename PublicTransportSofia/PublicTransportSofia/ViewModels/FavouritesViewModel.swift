//
//  FavouritesViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import SwiftUI

class FavouritesViewModel: ObservableObject {
    
    let sumcService: SUMCServiceProtocol
    @Binding var favourites: Favourites
    
    var stops: [Stop] {
        favourites.stopCodes
            .map({ code in sumcService.stops.first(where: { $0.code == code })
                ?? Stop(id: code, name: "N/A", coordinate: Coordinate()) })
    }
    
    var lines: [Line] {
        favourites.lineIds
            .map({ id in sumcService.lines.first(where: { $0.id == id })
                ?? Line(id: id, stops: []) })
    }
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>) {
        self.sumcService = sumcService
        self._favourites = favourites
    }
    
    func deleteStop(indexSet: IndexSet) {
        favourites.stopCodes.remove(atOffsets: indexSet)
    }
    
    func deleteLine(indexSet: IndexSet) {
        favourites.lineIds.remove(atOffsets: indexSet)
    }
    
    func moveStop(from: IndexSet, to: Int) {
        favourites.stopCodes.move(fromOffsets: from, toOffset: to)
    }
    
    func moveLine(from: IndexSet, to: Int) {
        favourites.lineIds.move(fromOffsets: from, toOffset: to)
    }
    
}
