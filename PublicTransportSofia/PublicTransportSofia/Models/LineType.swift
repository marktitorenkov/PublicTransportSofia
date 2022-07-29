//
//  LineType.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

enum LineType : String, Encodable, Decodable, Comparable, CustomStringConvertible {
    case bus
    case metro
    case tram
    case trolley
    
    static func < (lhs: LineType, rhs: LineType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    var description: String {
        switch self {
        case .bus: return "Bus"
        case .metro: return "Metro"
        case .tram: return "Tram"
        case .trolley: return "Trolley"
        }
    }
}
