//
//  ContentView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
