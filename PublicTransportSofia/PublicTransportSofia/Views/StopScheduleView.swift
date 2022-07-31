//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 27.07.22.
//

import SwiftUI

struct StopScheduleView: View {
    
    @StateObject private var viewModel: StopScheduleViewModel
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>, stop: Stop) {
        self._viewModel = StateObject(wrappedValue: StopScheduleViewModel(
            sumcService: sumcService,
            favourites: favourites,
            stop: stop))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.stop.name)
                .padding()
                .multilineTextAlignment(.center)
            if (!viewModel.fetchedSumc) {
                ProgressView()
            } else {
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
            }
        }
        .navigationBarTitle("Stop \(viewModel.stop.code)", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { viewModel.favourited.toggle() }) {
            Image(systemName: viewModel.favourited ? "star.fill" :  "star")
        })
        .task {
            try? await viewModel.fetchLineSchedule()
        }
    }
}

struct StopScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopScheduleView(
                sumcService: SUMCServiceMock(),
                favourites: .constant(FavouritesServiceMock().loadFavourites()),
                stop: Stop(id: "2222", name: "Obshtina mladost", coordinate: Coordinate(x: 1, y: 2)))
        }
    }
}
