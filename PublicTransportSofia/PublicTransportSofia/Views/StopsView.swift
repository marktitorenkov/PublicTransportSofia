//
//  StopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct StopsView: View {
    
    @EnvironmentObject var sumcDataStore: SUMCDataStore

    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { stop in
                    NavigationLink(destination: StopScheduleView(stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Stops")
        }
    }
    
    var searchResults: [Stop] {
        if searchText.isEmpty {
            return sumcDataStore.stops
        } else {
            return sumcDataStore.stops.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.code.contains(searchText)
            }
        }
    }
    
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
    }
}
