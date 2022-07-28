//
//  ContentView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct MainView: View {
    
    private let sumcService: SUMCServiceProtocol
    
    init(sumcService: SUMCServiceProtocol) {
        self.sumcService = sumcService
    }
    
    var body: some View {
        TabView {
            FavouritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }
            StopsView(sumcService: sumcService)
                .tabItem {
                    Image(systemName: "train.side.middle.car")
                    Text("Stops")
                }
            LinesView(sumcService: sumcService)
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
        .task {
            try? await sumcService.fetchStaticData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(sumcService: SUMCServiceMock())
    }
}
