//
//  LineStopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 27.07.22.
//

import SwiftUI

struct LineStopsView: View {
    
    @StateObject private var viewModel: LineStopsViewModel
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>, line: Line) {
        self._viewModel = StateObject(wrappedValue: LineStopsViewModel(
            sumcService: sumcService,
            favourites: favourites,
            line: line))
    }
    
    var body: some View {
        VStack {
            Picker("Direction", selection: $viewModel.direction) {
                ForEach(Array(viewModel.line.stops.enumerated()), id: \.0) { i, dir in
                    Text("\(dir.first?.name ?? "") - \(dir.last?.name ?? "")").tag(i)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            List {
                ForEach(viewModel.directonStops) { stop in
                    NavigationLink(destination: StopScheduleView(
                        sumcService: viewModel.sumcService,
                        favourites: $viewModel.favourites,
                        stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                    }
                }
            }
        }
        .navigationBarTitle("\(viewModel.line.id.type.description) \(viewModel.line.id.name)")
    }
}

struct LineStopsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LineStopsView(
                sumcService: SUMCServiceMock(),
                favourites: .constant(FavouritesServiceMock().loadFavourites()),
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
    }
}
