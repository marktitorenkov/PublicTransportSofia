//
//  JSONFavourites.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 29.07.22.
//

import Foundation

struct JSONFavourites: Decodable, Encodable {
    let stopCodes: [String]
    let lineIds: [LineIdentifier]
}
