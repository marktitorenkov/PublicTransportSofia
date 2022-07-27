//
//  LinesView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct LinesView: View {
    
    @State private var searchText = ""
    
    let lines: [Line] = [
        Line(id: LineIdentifier(name: "305", type: .bus), Stops: [
            [
                Stop(id: "0004", name: "Blok 411", coordinate: Coordinate(x: 0, y: 0)),
                Stop(id: "0005", name: "Blok 412", coordinate: Coordinate(x: 0, y: 0)),
                Stop(id: "0006", name: "Blok 413", coordinate: Coordinate(x: 0, y: 0)),
            ],
            [
                Stop(id: "0007", name: "Blok 413", coordinate: Coordinate(x: 0, y: 0)),
                Stop(id: "0008", name: "Blok 412", coordinate: Coordinate(x: 0, y: 0)),
                Stop(id: "0009", name: "Blok 411", coordinate: Coordinate(x: 0, y: 0)),
            ]
        ]),
        Line(id: LineIdentifier(name: "213", type: .bus), Stops: []),
        Line(id: LineIdentifier(name: "10", type: .tram), Stops: []),
        Line(id: LineIdentifier(name: "4", type: .trolley), Stops: []),
        Line(id: LineIdentifier(name: "4", type: .bus), Stops: []),
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResultsByType.keys.sorted(), id: \.self) { type in
                    Section(header: Text(type.description)) {
                        ForEach(searchResultsByType[type] ?? []) { line in
                            NavigationLink(destination: LineStopsView(line: line)) {
                                Text(line.id.name)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Lines")
        }
    }
    
    var searchResultsByType: [LineType : [Line]] {
        Dictionary(grouping: searchResults, by: { $0.id.type })
    }
    
    var searchResults: [Line] {
        if searchText.isEmpty {
            return lines
        } else {
            return lines.filter {
                $0.id.name.contains(searchText)
            }
        }
    }
}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        LinesView()
    }
}
