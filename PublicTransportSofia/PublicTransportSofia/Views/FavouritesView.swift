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
                    .onDelete(perform: favouritesStore.deleteStops)
                    .onMove(perform: favouritesStore.moveStops)
                }
                Section(header: Text("Lines")) {
                    ForEach(lines) { line in
                        NavigationLink(destination: LineStopsView(line: line)) {
                            Text(line.displayName)
                        }
                    }
                    .onDelete(perform: favouritesStore.deleteLines)
                    .onMove(perform: favouritesStore.moveLines)
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
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
            .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
    }
}
