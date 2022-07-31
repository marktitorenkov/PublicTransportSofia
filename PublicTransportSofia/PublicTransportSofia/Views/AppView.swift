//
//  AppView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 31.07.22.
//

import SwiftUI

struct AppView: View {
    
    @StateObject var sumcDataStore = SUMCDataStore(sumcService: SUMCService())
    @StateObject var favouritesStore = FavouritesStore(favouritesService: FavouritesService())
    
    var body: some View {
        MainView()
            .environmentObject(sumcDataStore)
            .environmentObject(favouritesStore)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
