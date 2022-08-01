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
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSearchResults(sumcDataStore, locationManager)) { stop in
                    NavigationLink(destination: StopScheduleView(stop: stop.stop)) {
                        HStack {
                            Text("\(stop.stop.name) (\(stop.stop.code))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            if viewModel.sort == .byLocation {
                                Text(viewModel.formatDistance(distance: stop.distance))
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .frame(alignment: .trailing)
                            }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Stops")
            .navigationBarItems(trailing: Menu("Sort") {
                Picker("", selection: $viewModel.sort) {
                    Text("Code").tag(StopsViewModel.Sort.byCode)
                    Text("Name").tag(StopsViewModel.Sort.byName)
                    Text("Location").tag(StopsViewModel.Sort.byLocation)
                }
            })
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
    }
}
