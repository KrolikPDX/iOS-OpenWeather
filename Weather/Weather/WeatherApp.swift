//
//  WeatherApp.swift
//  Weather
//
//  Created by Joseph Demyanovskiy on 12/10/20.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    var body: some Scene {
        WindowGroup {
            StartingView(viewModel: WeatherModel(ws: WeatherService())) //Start off with the loading screen
        }
    }
}

