//
//  SUMCServiceProtocol.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 28.07.22.
//

import Foundation

protocol SUMCServiceProtocol {
    
    func fetchStaticData() async throws -> ()
    
    func fetchSchedule(stopCode: String) async throws -> [LineSchedule]
    
    var lines: [Line] { get }
    
    var stops: [Stop] { get }
    
}
