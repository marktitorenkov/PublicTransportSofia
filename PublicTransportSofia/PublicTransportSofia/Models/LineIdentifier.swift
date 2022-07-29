//
//  LineIdentifier.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct LineIdentifier: Hashable, Decodable, Encodable {
    let name: String
    let type: LineType
}
