//
//  File.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import Foundation

struct Line: Identifiable {
    let id: LineType
    let Stops: [[Stop]]
}