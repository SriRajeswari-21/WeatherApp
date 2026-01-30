import Foundation

//enum Weather {
//    case sunny
//    case foggy
//    case snow
//    case rainy
//    case windy
//
//    var icon: String {
//        switch self {
//        case .sunny: return "sun.max.fill"
//        case .foggy: return "cloud.fog.fill"
//        case .snow: return "snowflake"
//        case .rainy: return "cloud.rain.fill"
//        case .windy: return "wind"
//        }
//    }
//
//    
enum Weather {
    case clear(isDay: Bool)
    case cloudy(isDay: Bool)
    case fog
    case rain(isDay: Bool)
    case snow
    case thunderstorm(isDay: Bool)
    case unknown

    init(weatherCode: Int, isDay: Bool) {
        switch weatherCode {
        case 0:
            self = .clear(isDay: isDay)
        case 1, 2:
            self = .cloudy(isDay: isDay)
        case 3,45, 48:
            self = .fog
        case 51...67, 80...82:
            self = .rain(isDay: isDay)
        case 71...77, 85...86:
            self = .snow
        case 95...99:
            self = .thunderstorm(isDay: isDay)
        default:
            self = .unknown
        }
    }

    var icon: String {
        switch self {
        case .clear(let isDay):
            return isDay ? "sun.max.fill" : "moon.stars.fill"
        case .cloudy(let isDay):
            return isDay ? "cloud.sun.fill" : "cloud.moon.fill"
        case .fog:
            return "cloud.fog.fill"
        case .rain(let isDay):
            return isDay ? "cloud.rain.fill" : "cloud.moon.rain.fill"
        case .snow:
            return "snowflake"
        case .thunderstorm(let isDay):
            return isDay ? "cloud.bolt.rain.fill" : "cloud.moon.bolt.fill"
        case .unknown:
            return "questionmark"
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
