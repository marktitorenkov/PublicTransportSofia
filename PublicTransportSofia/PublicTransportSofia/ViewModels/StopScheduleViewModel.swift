//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 29.07.22.
//

import SwiftUI

class StopScheduleViewModel: ObservableObject {
    
    private let sumcService: SUMCServiceProtocol
    @Binding private(set) var favourites: Favourites
    let stop: Stop
    
    @Published var lineSchedules: [LineSchedule] = []
    @Published var fetchedSumc: Bool = false
    
    var favourited: Bool {
        get { favourites.getStop(code: stop.code) }
        set(value) { favourites.updateStop(code: stop.code, favourited: value) }
    }
    
    init(sumcService: SUMCServiceProtocol, favourites: Binding<Favourites>, stop: Stop) {
        self.sumcService = sumcService
        self._favourites = favourites
        self.stop = stop
    }
    
    func fetchLineSchedule() async throws {
        let fetched = try await sumcService.fetchSchedule(stopCode: stop.code)
        
        await MainActor.run {
            lineSchedules = fetched
            fetchedSumc = true
        }
    }
    
    func arrivalFormat(_ arrival: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: arrival)
    }
    
}
