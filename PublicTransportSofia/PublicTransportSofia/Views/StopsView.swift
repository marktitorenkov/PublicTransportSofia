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
//                Section("Debug") {
//                    Button("Request", action: { locationManager.requestWhenInUseAuthorization() })
//                    Button("Start", action: { locationManager.startUpdatingLocation() })
//                    Button("Stop", action: { locationManager.stopUpdatingLocation() })
//                    Text("\(locationManager.locationStatus?.rawValue ?? 0)")
//                    Text("\(locationManager.lastLocation?.coordinate.latitude ?? 0) \(locationManager.lastLocation?.coordinate.longitude ?? 0)")
//                }
                ForEach(viewModel.getSearchResults(sumcDataStore, locationManager)) { stop in
                    NavigationLink(destination: StopScheduleView(stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
                            .lineLimit(1)
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
