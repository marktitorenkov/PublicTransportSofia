//
//  SwiftUIView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var favouritesStore: FavouritesStore
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Stops")) {
                    ForEach(stops) { stop in
                        NavigationLink(destination: StopScheduleView(stop: stop)) {
                            Text("\(stop.name) (\(stop.code))")
                                .lineLimit(1)
                        }
                    }
                    .onDelete(perform: deleteStop)
                    .onMove(perform: moveStop)
                }
                Section(header: Text("Lines")) {
                    ForEach(lines) { line in
                        NavigationLink(destination: LineStopsView(line: line)) {
                            Text(line.id.name)
                        }
                    }
                    .onDelete(perform: deleteLine)
                    .onMove(perform: moveLine)
                }
            }
            .navigationTitle("Favourites")
            .navigationBarItems(leading: EditButton())
        }
    }
    
    var stops: [Stop] {
        favouritesStore.favourites.stopCodes
            .map({ code in sumcDataStore.stops.first(where: { $0.code == code })
                ?? Stop(id: code, name: "N/A", coordinate: Coordinate()) })
    }
    
    var lines: [Line] {
        favouritesStore.favourites.lineIds
            .map({ id in sumcDataStore.lines.first(where: { $0.id == id })
                ?? Line(id: id, stops: []) })
    }
    
    func deleteStop(indexSet: IndexSet) {
        favouritesStore.favourites.stopCodes.remove(atOffsets: indexSet)
    }
    
    func deleteLine(indexSet: IndexSet) {
        favouritesStore.favourites.lineIds.remove(atOffsets: indexSet)
    }
    
    func moveStop(from: IndexSet, to: Int) {
        favouritesStore.favourites.stopCodes.move(fromOffsets: from, toOffset: to)
    }
    
    func moveLine(from: IndexSet, to: Int) {
        favouritesStore.favourites.lineIds.move(fromOffsets: from, toOffset: to)
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
            .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
    }
}
