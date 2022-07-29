//
//  SwiftUIView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct FavouritesView: View {
    
    @StateObject private var viewModel: FavouritesViewModel
    private let sumcService: SUMCServiceProtocol
    
    init(sumcService: SUMCServiceProtocol, favouritesService: FavouritesServiceProtocol) {
        self._viewModel = StateObject(wrappedValue: FavouritesViewModel(
            sumcService: sumcService,
            favouritesService: favouritesService))
        self.sumcService = sumcService
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Stops")) {
                    ForEach(viewModel.stops) { stop in
                        NavigationLink(destination: StopScheduleView(sumcService: sumcService, stop: stop)) {
                            Text(stop.code)
                        }
                    }
                    .onDelete(perform: viewModel.deleteStop)
                    .onMove(perform: viewModel.moveStop)
                }
                Section(header: Text("Lines")) {
                    ForEach(viewModel.lines) { line in
                        NavigationLink(destination: LineStopsView(sumcService: sumcService, line: line)) {
                            Text(line.id.name)
                        }
                    }
                    .onDelete(perform: viewModel.deleteLine)
                    .onMove(perform: viewModel.moveLine)
                }
            }
            .navigationTitle("Favourites")
            .navigationBarItems(leading: EditButton())
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(sumcService: SUMCServiceMock(), favouritesService: FavouritesServiceMock())
    }
}
