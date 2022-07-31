//
//  StopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct StopsView: View {
    
    @StateObject private var viewModel: StopsViewModel
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>) {
        self._viewModel = StateObject(wrappedValue: StopsViewModel(
            sumcService: sumcService,
            favourites: favourites))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.searchResults) { stop in
                    NavigationLink(destination: StopScheduleView(
                        sumcService: viewModel.sumcService,
                        favourites: $viewModel.favourites,
                        stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Stops")
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView(
            sumcService: SUMCServiceMock(),
            favourites: .constant(FavouritesServiceMock().loadFavourites()))
    }
}
