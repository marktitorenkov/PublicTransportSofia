//
//  ContentView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var sumcDataStore: SumcDataStore
    @EnvironmentObject var favouritesStore: FavouritesStore
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        if viewModel.sumcFetched {
            TabView {
                FavouritesView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favourites")
                    }
                StopsView()
                    .tabItem {
                        Image(systemName: "train.side.middle.car")
                        Text("Stops")
                    }
                LinesView()
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
            
        } else {
            MainLoadingView()
                .task {
                    await viewModel.fetchSumcData(sumcDataStore)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SumcDataStore(sumcService: SumcServiceMock()))
            .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
    }
}
