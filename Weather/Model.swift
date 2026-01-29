import Foundation

enum Weather {
    case sunny
    case foggy
    case snow
    case rainy
    case windy

    var icon: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .foggy: return "cloud.fog.fill"
        case .snow: return "snowflake"
        case .rainy: return "cloud.rain.fill"
        case .windy: return "wind"
        }
    }

    
}

struct Temperature {
    let min: Int
    let max: Int

    var temperatureText: String {
        "\(min) °C / \(max) °C"
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let weather: Weather
    let temperature: Double
    let latitude: Double
    let longitude: Double

    init(name: String, weather: Weather, temperature: Double=0.0, latitude: Double = 0.0, longitude: Double = 0.0) {
        self.name = name
        self.weather = weather
        self.temperature = temperature
        self.latitude = latitude
        self.longitude = longitude
    }
}
