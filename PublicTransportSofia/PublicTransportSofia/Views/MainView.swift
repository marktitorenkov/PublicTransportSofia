//
//  ContentView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    @EnvironmentObject var favouritesStore: FavouritesStore
    
    @State var sumcFetched = false
    
    var body: some View {
        if sumcFetched {
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
                    try? await sumcDataStore.fetchStaticData()
                    sumcFetched = true
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
            .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
    }
}
