//
//  WeatherApp.swift
//  Weather
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

@main
struct WeatherApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                            LandingScreen().environment(
                                \.managedObjectContext,
                                persistenceController.context
                            )

                        }
        }
    }
}


   
