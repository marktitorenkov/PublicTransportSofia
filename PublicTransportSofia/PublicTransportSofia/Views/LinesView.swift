//
//  LinesView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct LinesView: View {
    
    @EnvironmentObject var sumcDataStore: SumcDataStore
    @StateObject var viewModel: LinesViewModel = LinesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getSearchResults(sumcDataStore)) { lineByType in
                    Section(header: Text(lineByType.id.description)) {
                        ForEach(lineByType.lines) { line in
                            NavigationLink(destination: LineStopsView(line: line)) {
                                Text(line.displayName)
                                    .lineLimit(1)
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
        LinesView()
            .environmentObject(SumcDataStore(sumcService: SumcServiceMock()))
    }
}
