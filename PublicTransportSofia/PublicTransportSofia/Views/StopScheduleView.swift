//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 27.07.22.
//

import SwiftUI

struct StopScheduleView: View {
    
    let stop: Stop
    @EnvironmentObject var sumcDataStore: SUMCDataStore
    @EnvironmentObject var favouritesStore: FavouritesStore
    
    @State var lineSchedules: [LineSchedule]? = nil
    
    var body: some View {
        VStack {
            Text(stop.name)
                .padding()
                .multilineTextAlignment(.center)
            if let schedules = lineSchedules {
                List {
                    ForEach(schedules) { schedule in
                        Section(header: Text(schedule.line.name).font(.headline)) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(schedule.arrivals, id: \.self) { arrival in
                                        Button(arrivalFormat(arrival), action: {})
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
            lineSchedules = await sumcDataStore.fetchLineSchedule(stopCode: stop.code)
        }
    }
    
    func arrivalFormat(_ arrival: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: arrival)
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
