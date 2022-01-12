//
//  LENAApp.swift
//  LENA
//
//  Created by SEAN BLAKE on 1/11/22.
//

import SwiftUI

@main
struct LENAApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
