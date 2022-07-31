//
//  LineStopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 27.07.22.
//

import SwiftUI

struct LineStopsView: View {
    
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    @EnvironmentObject var favouritesStore: FavouritesStore
    
    let line: Line
    @State var direction = 0
    
    var body: some View {
        VStack {
            Picker("Direction", selection: $direction) {
                ForEach(Array(line.stops.enumerated()), id: \.0) { i, dir in
                    Text("\(dir.first?.name ?? "") - \(dir.last?.name ?? "")").tag(i)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            List {
                ForEach(directonStops) { stop in
                    NavigationLink(destination: StopScheduleView(stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                            .lineLimit(1)
                    }
                }
            }
        }
        .navigationBarTitle("\(line.id.type.description) \(line.displayName)")
        .navigationBarItems(trailing: Button(action: { favouritesStore.toggleLine(id: line.id) }) {
            Image(systemName: favouritesStore.getLine(id: line.id) ? "star.fill" :  "star")
        })
    }
    
    var directonStops: [Stop] {
        return line.stops.indices.contains(direction)
        ? line.stops[direction]
        : []
    }
    
}

struct LineStopsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LineStopsView(
                line: Line(id: LineIdentifier(name: "305", type: .bus), stops: [
                    [
                        Stop(id: "0004", name: "Blok 411", coordinate: Coordinate(x: 0, y: 0)),
                        Stop(id: "0005", name: "Blok 412", coordinate: Coordinate(x: 0, y: 0)),
                    ],
                    [
                        Stop(id: "0007", name: "Blok 413", coordinate: Coordinate(x: 0, y: 0)),
                        Stop(id: "0008", name: "Blok 412", coordinate: Coordinate(x: 0, y: 0)),
                    ],
                ]))
        }
        .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
        .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
    }
}
