//
//  ContentView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel
    @StateObject private var favouritesStore: FavouritesStore
    
    init(sumcService: SUMCServiceProtocol, favouritesService: FavouritesServiceProtocol) {
        self._viewModel = StateObject(wrappedValue: MainViewModel(
            sumcService: sumcService,
            favouritesService: favouritesService))
        self._favouritesStore = StateObject(wrappedValue: FavouritesStore(favouritesService: favouritesService))
    }
    
    var body: some View {
        if !viewModel.fetchedSumc {
            MainLoadingView()
                .task {
                    try? await viewModel.fetchStaticData()
                }
        } else {
            TabView {
                FavouritesView(sumcService: viewModel.sumcService, favourites: $viewModel.favourites)
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favourites")
                    }
                StopsView(sumcService: viewModel.sumcService, favourites: $viewModel.favourites)
                    .tabItem {
                        Image(systemName: "train.side.middle.car")
                        Text("Stops")
                    }
                LinesView(sumcService: viewModel.sumcService, favourites: $viewModel.favourites)
                    .tabItem {
                        Image(systemName: "bus.fill")
                        Text("Lines")
                    }
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Notifications")
                    }
            }
            .environmentObject(favouritesStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            sumcService: SUMCServiceMock(),
            favouritesService: FavouritesServiceMock())
    }
}
