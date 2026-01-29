//
//  PersistenceController.swift
//  Weather
//
//  Created by rentamac on 1/28/26.
//

import Foundation
import Foundation
import CoreData

final class PersistenceController {

    // MARK: - Singleton
    static let shared = PersistenceController()

    // MARK: - Core Data Stack
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: - Save
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }

    // MARK: - CREATE
    func createLocation(
        name: String,
        latitude: Double,
        longitude: Double,
        temperature: Double
    ) {
        let location = WeatherLocation(context: context)
        location.id = UUID()
        location.name = name
        location.latitude = latitude
        location.longitude = longitude
        location.temperature = temperature
        location.isSynced = true
        location.updatedAt = Date()

        save()
    }

    // MARK: - READ
    func fetchLocations() -> [WeatherLocation] {
        let request = NSFetchRequest<WeatherLocation>(entityName: "WeatherLocation")
        request.sortDescriptors = [
            NSSortDescriptor(key: "updatedAt", ascending: false)
        ]

        return (try? context.fetch(request)) ?? []
    }

    // MARK: - UPDATE
    func updateLocation(
        _ location: WeatherLocation,
        temperature: Double
    ) {
        location.temperature = temperature
        location.updatedAt = Date()
        location.isSynced = true
        save()
    }

    // MARK: - DELETE
    func deleteLocation(_ location: WeatherLocation) {
        context.delete(location)
        save()
    }
}

