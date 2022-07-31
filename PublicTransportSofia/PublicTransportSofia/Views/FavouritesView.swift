//
//  SwiftUIView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct FavouritesView: View {
    
    @StateObject private var viewModel: FavouritesViewModel
    @Binding private var test: Favourites
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>) {
        self._viewModel = StateObject(wrappedValue: FavouritesViewModel(
            sumcService: sumcService,
            favourites: favourites))
        self._test = favourites
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Stops")) {
                    ForEach(viewModel.stops) { stop in
                        NavigationLink(destination: StopScheduleView(
                            sumcService: viewModel.sumcService,
                            favourites: $viewModel.favourites,
                            stop: stop)) {
                                Text(stop.code)
                            }
                    }
                    .onDelete(perform: viewModel.deleteStop)
                    .onMove(perform: viewModel.moveStop)
                }
                Section(header: Text("Lines")) {
                    ForEach(viewModel.lines) { line in
                        NavigationLink(destination: LineStopsView(
                            sumcService: viewModel.sumcService,
                            favourites: $viewModel.favourites,
                            line: line)) {
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
        FavouritesView(
            sumcService: SUMCServiceMock(),
            favourites: .constant(FavouritesServiceMock().loadFavourites()))
    }
}
