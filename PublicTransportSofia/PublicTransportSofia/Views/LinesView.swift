//
//  LinesView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct LinesView: View {
    
    @StateObject private var viewModel: LinesViewModel
    
    init(sumcService: SUMCServiceProtocol) {
        _viewModel = StateObject(wrappedValue: LinesViewModel(sumcService: sumcService))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.searchResultsByType.keys.sorted(), id: \.self) { type in
                    Section(header: Text(type.description)) {
                        ForEach(viewModel.searchResultsByType[type] ?? []) { line in
                            NavigationLink(destination: LineStopsView(line: line)) {
                                Text(line.id.name)
                            }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Lines")
        }
    }
}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        LinesView(sumcService: SUMCServiceMock())
    }
}
