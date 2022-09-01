//
//  StopWithDistance.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 1.08.22.
//

import Foundation

struct StopWithDistance: Identifiable, Equatable {
    var id: String { stop.id }
    let stop: Stop
    let distance: Double
}
