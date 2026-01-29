//
//  ListViewModel.swift
//  Weather
//
//  Created by rentamac on 1/23/26.
//


import Foundation
import Combine
@MainActor
final class CityListViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published private(set) var locations: [Location] = []

    private let persistenceController = PersistenceController.shared

    private let defaultCities: [(String, Double, Double)] = [
        ("Mumbai", 19.0760, 72.8777),
        ("New Delhi", 28.6139, 77.2090),
        ("Chennai", 13.0827, 80.2707),
        ("Pune", 18.5204, 73.8567),
        ("Bengaluru", 12.9716, 77.5946),
        ("Gurgaon", 28.4595, 77.0266),
        ("Noida", 28.5355, 77.3910),
        ("Hyderabad", 17.3850, 78.4867),
        ("Ahmedabad", 23.0225, 72.5714),
        ("Indore", 22.7196, 75.8577)
    ]

    init() {
        addDefaultCitiesIfNeeded()
        fetchLocations()
    }

    func fetchLocations() {
        let coreDataLocations = persistenceController.fetchLocations()
        print("📦 CORE DATA FETCH COUNT:", coreDataLocations.count)

            coreDataLocations.forEach {
                print("🗂️ \($0.name ?? "nil") | temp: \($0.temperature)")
            }
        self.locations = coreDataLocations.map {
            Location(
                name: $0.name ?? "Unknown",
                weather: .sunny,
                temperature: $0.temperature,
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
    }

    private func addDefaultCitiesIfNeeded() {
        let existing = persistenceController.fetchLocations()
        guard existing.isEmpty else { return }

        for city in defaultCities {
            persistenceController.createLocation(
                name: city.0,
                latitude: city.1,
                longitude: city.2,
                temperature: 0
            )
        }

        persistenceController.save()
    }

    var filteredLocations: [Location] {
        guard !searchText.isEmpty else { return locations }

        return locations.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}
