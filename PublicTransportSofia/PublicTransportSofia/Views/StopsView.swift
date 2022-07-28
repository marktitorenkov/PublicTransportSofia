//
//  StopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct StopsView: View {
    
    @StateObject private var viewModel: StopsViewModel
    
    private let sumcService: SUMCServiceProtocol
    
    init(sumcService: SUMCServiceProtocol) {
        _viewModel = StateObject(wrappedValue: StopsViewModel(sumcService: sumcService))
        self.sumcService = sumcService
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.searchResults) { stop in
                    NavigationLink(destination: StopScheduleView(sumcService: sumcService, stop: stop)) {
                        Text("\(stop.name) (\(stop.code))")
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
        StopsView(sumcService: SUMCServiceMock())
    }
}
