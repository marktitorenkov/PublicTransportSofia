//
//  SwiftUIView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var favouritesStore: FavouritesStore
    @EnvironmentObject var sumcDataStore: SumcDataStore
    @StateObject var viewModel: FavouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Stops")) {
                    ForEach(viewModel.getStops(favouritesStore, sumcDataStore)) { stop in
                        NavigationLink(destination: StopScheduleView(stop: stop)) {
                            Text("\(stop.name) (\(stop.code))")
                                .lineLimit(1)
                        }
                    }
                    .onDelete(perform: favouritesStore.deleteStops)
                    .onMove(perform: favouritesStore.moveStops)
                }
                Section(header: Text("Lines")) {
                    ForEach(viewModel.getLines(favouritesStore, sumcDataStore)) { line in
                        NavigationLink(destination: LineStopsView(line: line)) {
                            Text(line.displayName)
                        }
                    }
                    .onDelete(perform: favouritesStore.deleteLines)
                    .onMove(perform: favouritesStore.moveLines)
                }
            }
            .navigationTitle("Favourites")
            .navigationBarItems(leading: EditButton())
        }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environmentObject(SumcDataStore(sumcService: SumcServiceMock()))
            .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
    }
}
