//
//  LineStopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 27.07.22.
//

import SwiftUI

struct LineStopsView: View {
    
    private let sumcService: SUMCServiceProtocol
    private let line: Line
    
    init(sumcService: SUMCServiceProtocol, line: Line) {
        self.sumcService = sumcService
        self.line = line
    }
    
    @State private var direction = 0
    private var directonStops: [Stop] {
        return line.Stops.indices.contains(direction)
        ? line.Stops[direction]
        : []
    }
    
    var body: some View {
        VStack {
            Picker("Direction", selection: $direction) {
                ForEach(Array(line.Stops.enumerated()), id: \.0) { i, dir in
                    Text("\(dir.first?.name ?? "") - \(dir.last?.name ?? "")").tag(i)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            List {
                ForEach(directonStops) { stop in
                    NavigationLink(destination: StopScheduleView(sumcService: sumcService, stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                    }
                }
            }
        }
        .navigationBarTitle("\(line.id.type.description) \(line.id.name)")
    }
}

struct LineStopsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LineStopsView(sumcService: SUMCServiceMock(), line: Line(id: LineIdentifier(name: "305", type: .bus), Stops: [
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
    }
}
