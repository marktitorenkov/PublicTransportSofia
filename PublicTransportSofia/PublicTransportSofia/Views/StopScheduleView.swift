//
//  StopScheduleView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 27.07.22.
//

import SwiftUI

struct StopScheduleView: View {
    
    let lineSchedules: [LineSchedule] = [
        LineSchedule(id: LineIdentifier(name: "305", type: .bus), arrivals: [Date() + 100, Date() + 5 * 60, Date() + 15 * 60]),
        LineSchedule(id: LineIdentifier(name: "10", type: .tram), arrivals: [Date() + 50, Date() + 3 * 60]),
        LineSchedule(id: LineIdentifier(name: "15", type: .tram), arrivals: [Date() + 50, Date() + 3 * 60]),
    ]
    
    let stop: Stop
    
    init(stop: Stop) {
        self.stop = stop
    }
    
    var body: some View {
        VStack {
            Text(stop.name)
                .multilineTextAlignment(.center)
            List {
                ForEach(lineSchedules) { schedule in
                    Section(header: Text(schedule.line.name).font(.headline)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(schedule.arrivals, id: \.self) { arrival in
                                    Text(arrival.formatted(.dateTime.hour().minute()))
                                        .font(.system(size: 20))
                                        .padding(20)
                                        .background(Color(.white))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .listRowBackground(Color.black.opacity(0))
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarTitle("Stop \(stop.code)", displayMode: .inline)
    }
}

struct StopScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StopScheduleView(stop: Stop(id: "2222", name: "Obshtina mladost", coordinate: Coordinate(x: 1, y: 2)))
        }
    }
}
