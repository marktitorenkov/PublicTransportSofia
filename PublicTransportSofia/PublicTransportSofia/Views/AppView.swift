//
//  AppView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import SwiftUI

// Used to setup all dependencies
struct AppView: View {
    
    @StateObject var sumcDataStore = SumcDataStore(sumcService: SumcService(api: SumcApiService()))
    @StateObject var favouritesStore = FavouritesStore(favouritesService: FavouritesService())
    
    var body: some View {
        MainView()
            .environmentObject(sumcDataStore)
            .environmentObject(favouritesStore)
    }
}
