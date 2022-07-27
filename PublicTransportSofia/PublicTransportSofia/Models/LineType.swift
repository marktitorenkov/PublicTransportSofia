//
//  LineType.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

enum LineType : Comparable, CustomStringConvertible {
    case bus
    case metro
    case tram
    case trolley
    
    var description: String {
        switch self {
        case .bus: return "Bus"
        case .metro: return "Metro"
        case .tram: return "Tram"
        case .trolley: return "Trolley"
        }
    }
}
