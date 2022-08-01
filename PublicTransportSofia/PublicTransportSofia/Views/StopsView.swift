//
//  StopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct StopsView: View {
    
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    @StateObject var viewModel: StopsViewModel = StopsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSearchResults(sumcDataStore)) { stop in
                    NavigationLink(destination: StopScheduleView(stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                            .lineLimit(1)
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
        StopsView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
    }
}
