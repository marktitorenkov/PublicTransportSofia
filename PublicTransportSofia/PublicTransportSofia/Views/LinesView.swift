//
//  LinesView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct LinesView: View {
    
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResultsByType.keys.sorted(), id: \.self) { type in
                    Section(header: Text(type.description)) {
                        ForEach(searchResultsByType[type] ?? []) { line in
                            NavigationLink(destination: LineStopsView(line: line)) {
                                Text(line.id.name)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Lines")
        }
    }
    
    var searchResultsByType: [LineType : [Line]] {
        Dictionary(grouping: searchResults, by: { $0.id.type })
    }
    
    var searchResults: [Line] {
        if searchText.isEmpty {
            return sumcDataStore.lines
        } else {
            return sumcDataStore.lines.filter {
                $0.id.name.contains(searchText)
            }
        }
    }
    
}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        LinesView()
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
    }
}
