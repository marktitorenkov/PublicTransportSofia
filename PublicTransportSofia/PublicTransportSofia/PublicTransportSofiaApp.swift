//
//  PublicTransportSofiaApp.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

@main
struct PublicTransportSofiaApp: App {
    let sumcService = SUMCService()
    
    var body: some Scene {
        WindowGroup {
            MainView(sumcService: sumcService)
        }
    }
}
