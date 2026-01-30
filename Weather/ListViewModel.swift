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
    @Published var searchLocation: String = ""
    @Published private(set) var locations: [Location] = []
    @Published var isAdding: Bool = false
       @Published var errorMessage: String?

    private let persistenceController = PersistenceController.shared
    private let geocodingService: GeocodingServiceProtocol

     private var defaultCities: [(String, Double, Double)] = [
        // 🇮🇳 India
        ("Mumbai", 19.0760, 72.8777),
        ("New Delhi", 28.6139, 77.2090),
        ("Chennai", 13.0827, 80.2707),
        ("Pune", 18.5204, 73.8567),
        ("Bengaluru", 12.9716, 77.5946),
        ("Gurgaon", 28.4595, 77.0266),
        ("Noida", 28.5355, 77.3910),
        ("Hyderabad", 17.3850, 78.4867),
        ("Ahmedabad", 23.0225, 72.5714),
        ("Indore", 22.7196, 75.8577),

        // ❄️ Snow / Cold (should give snow / fog)
        ("Reykjavik", 64.1466, -21.9426),
        ("Helsinki", 60.1699, 24.9384),
        ("Moscow", 55.7558, 37.6173),

        // 🌧️ Rain-heavy regions
        ("London", 51.5074, -0.1278),
        ("Seattle", 47.6062, -122.3321),
        ("Singapore", 1.3521, 103.8198),

        // 🌫️ Fog / Overcast
        ("San Francisco", 37.7749, -122.4194),

        // 🌨️ Extreme cold / night visibility
        ("Ushuaia", -54.8019, -68.3030),
        ("Antarctica", -82.8628, 135.0000)
    ]
   // print(defaultCities)
   


    init(geocodingService: GeocodingServiceProtocol = GeocodingService()) {
        self.geocodingService = geocodingService
        addDefaultCitiesIfNeeded()
        fetchLocations()
       
    }

    func fetchLocations() {
        let coreDataLocations = persistenceController.fetchLocations()
        print("📦 CORE DATA FETCH COUNT:", coreDataLocations.count)

        coreDataLocations.forEach {
            print(
                "🗂️",
                $0.name ?? "nil",
                "| temp:", $0.temperature,
                "| weatherCode:", $0.weatherCode,
                "| isDay:", $0.isDay
            )
        }
        self.locations = coreDataLocations.map {
            let weather = Weather(
                    weatherCode: Int($0.weatherCode),
                    isDay: $0.isDay
                )
          return  Location(
                name: $0.name ?? "Unknown",
                weather: weather,
                temperature: $0.temperature,
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
    }

    private func addDefaultCitiesIfNeeded() {
        let existing = persistenceController.fetchLocations()
        let existingNames = Set(existing.compactMap { $0.name })

        for city in defaultCities {
            if !existingNames.contains(city.0) {
                persistenceController.createLocation(
                    name: city.0,
                    latitude: city.1,
                    longitude: city.2,
                    temperature: 0,
                    weatherCode: 0,
                    isDay: false
                )
            }
        }

        persistenceController.save()
    }
    func addCity() async {
        guard !searchLocation.isEmpty else { return }
        
        do {
            let result = try await geocodingService.fetchCoordinates(for: searchLocation)
            
            persistenceController.createLocation(name: result.name, latitude: result.latitude, longitude: result.longitude, temperature: 0, weatherCode: 0, isDay: false)
//            (
//                name: result.name,
//                latitude: result.latitude,
//                longitude: result.longitude
//            )
        defaultCities.append((result.name, result.latitude, result.longitude))
        defaultCities.forEach { city in
            print("City: \(city.0), Lat: \(city.1), Lon: \(city.2)")
        }
        //addDefaultCitiesIfNeeded()
        
        searchLocation = ""
        fetchLocations()
    

           } catch {
               errorMessage = "Could not find location"
              // print(errorMessage)
           }
       }


    var filteredLocations: [Location] {
        guard !searchText.isEmpty else { return locations }

        return locations.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}
