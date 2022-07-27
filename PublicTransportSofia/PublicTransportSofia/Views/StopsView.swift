//
//  StopsView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct StopsView: View {
    
    @State private var searchText = ""
    
    var stops: [Stop] = [
        Stop(id: "2224", name: "Община младост", coordinate: Coordinate(x: 0, y: 0)),
        Stop(id: "0012", name: "Kur", coordinate: Coordinate(x: 1, y: 1)),
        Stop(id: "0001", name: "Кулинарен комбинат Пейфил Последната спирка на 305", coordinate: Coordinate(x: 0, y: 0)),
    ]
    
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
            return stops
        } else {
            return stops.filter {
                $0.name.contains(searchText) || $0.code.contains(searchText)
            }
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
    }
}
