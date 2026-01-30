import Foundation
import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

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
        temperature: Double,weatherCode: Int,
        isDay:Bool
    ) {
        let location = WeatherLocation(context: context)
        location.id = UUID()
        location.name = name
        location.latitude = latitude
        location.longitude = longitude
        location.temperature = temperature

       
        location.weatherCode = Int16(weatherCode)
        
        location.isDay = isDay

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

    // MARK: - UPDATE (IMPORTANT)
    func updateLocation(
        _ location: WeatherLocation,
        temperature: Double,
        weatherCode: Int,
        isDay: Bool
    ) {
        location.temperature = temperature
        location.weatherCode = Int16(weatherCode)
        location.isDay = isDay
        location.updatedAt = Date()
        save()
    }
}

