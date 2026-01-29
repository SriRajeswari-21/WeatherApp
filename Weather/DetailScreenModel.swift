import Foundation
import Combine
import CoreData

@MainActor
final class LocationDetailViewModel: ObservableObject {

    // MARK: - UI State
    @Published var isLoading: Bool = false
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?

    // MARK: - Dependencies
    private let weatherService: WeatherServiceProtocol
    private let persistenceController: PersistenceController

    // MARK: - Init
    init(
        weatherService: WeatherServiceProtocol,
        persistenceController: PersistenceController = .shared
    ) {
        self.weatherService = weatherService
        self.persistenceController = persistenceController
    }

    // MARK: - Fetch Weather
    func loadWeather(
        latitude: Double,
        longitude: Double,
        locationName: String
    ) async {

        isLoading = true
        errorMessage = nil

        do {
            let response = try await weatherService.fetchWeather(
                latitude: latitude,
                longitude: longitude
            )

            self.weather = response

            // ✅ SAVE / UPDATE CORE DATA
            saveOrUpdateLocation(
                name: locationName,
                latitude: latitude,
                longitude: longitude,
                temperature: response.current.temperature2M
            )

        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Core Data
    private func saveOrUpdateLocation(
        name: String,
        latitude: Double,
        longitude: Double,
        temperature: Double
    ) {

        let locations = persistenceController.fetchLocations()

        if let existingLocation = locations.first(
            where: { $0.name == name }
        ) {
            // UPDATE
            persistenceController.updateLocation(
                existingLocation,
                temperature: temperature
            )
        } else {
            // CREATE
            persistenceController.createLocation(
                name: name,
                latitude: latitude,
                longitude: longitude,
                temperature: temperature
            )
        }
    }
}
