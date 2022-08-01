//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 27.07.22.
//

import SwiftUI

struct StopScheduleView: View {
    
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    @EnvironmentObject var favouritesStore: FavouritesStore
    @StateObject var viewModel: StopScheduleViewModel = StopScheduleViewModel()
    let stop: Stop
    
    var body: some View {
        VStack {
            Text(stop.name)
                .padding()
                .multilineTextAlignment(.center)
            if viewModel.lineSchedulesLoaded {
                List {
                    ForEach(viewModel.lineSchedules) { schedule in
                        Section(header: Text(schedule.line.name).font(.headline)) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(schedule.arrivals, id: \.self) { arrival in
                                        Button(viewModel.arrivalFormat(arrival), action: {})
                                            .buttonStyle(.bordered)
                                            .controlSize(.large)
                                            .padding(5)
                                    }
                                }
                            }
                            .listRowBackground(Color.black.opacity(0))
                        }
                    }
                }
                .listStyle(.insetGrouped)
            } else {
                ProgressView()
            }
        }
        .navigationBarTitle("Stop \(stop.code)", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { favouritesStore.toggleStop(code: stop.code) }) {
            Image(systemName: favouritesStore.getStop(code: stop.code) ? "star.fill" :  "star")
        })
        .task {
            await viewModel.fetchLineSchedule(sumcDataStore, stop: stop)
        }
    }
    
}

struct StopScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopScheduleView(
                stop: Stop(id: "2222", name: "Obshtina mladost", coordinate: Coordinate(x: 1, y: 2)))
            .environmentObject(SUMCDataStore(sumcService: SUMCServiceMock()))
            .environmentObject(FavouritesStore(favouritesService: FavouritesServiceMock()))
        }
    }
}
