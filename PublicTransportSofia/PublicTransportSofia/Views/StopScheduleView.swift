//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 27.07.22.
//

import SwiftUI

struct StopScheduleView: View {
    
    @StateObject private var viewModel: StopScheduleViewModel
    let stop: Stop
    
    init(sumcService: SUMCServiceProtocol, stop: Stop) {
        self._viewModel = StateObject(wrappedValue: StopScheduleViewModel(sumcService: sumcService))
        self.stop = stop
    }
    
    var body: some View {
        VStack {
            Text(stop.name)
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
                                        Button(arrival.formatted(.dateTime.hour().minute()), action: {})
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
        .navigationBarTitle("Stop \(stop.code)", displayMode: .inline)
        .task {
            try? await viewModel.fetchLineSchedule(stopCode: stop.code)
        }
    }
}

struct StopScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopScheduleView(sumcService: SUMCServiceMock(), stop: Stop(id: "2222", name: "Obshtina mladost", coordinate: Coordinate(x: 1, y: 2)))
        }.preferredColorScheme(.light)
    }
}
