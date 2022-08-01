//
//  StopScheduleViewModel.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 1.08.22.
//

import Foundation

class StopScheduleViewModel: ObservableObject {
    
    @Published private var schedules: [LineSchedule]? = nil
    
    var lineSchedulesLoaded: Bool {
        schedules != nil
    }
    
    var lineSchedules: [LineSchedule] {
        schedules ?? []
    }
    
    func getMapUrl(stop: Stop) -> URL {
        return URL(string: "maps://?saddr=&daddr=\(stop.coordinate.lat),\(stop.coordinate.lon)")!
    }
    
    func fetchLineSchedule(_ sumcDataStore: SumcDataStore, stop: Stop) async -> () {
        let schedules = await sumcDataStore.fetchLineSchedule(stopCode: stop.code)
        await MainActor.run {
            self.schedules = schedules
        }
    }
    
    func arrivalFormat(_ arrival: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: arrival)
    }
    
}
