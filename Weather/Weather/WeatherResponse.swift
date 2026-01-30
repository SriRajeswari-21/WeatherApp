//
//  WeatherResponse.swift
//  Weather
//
//  Created by rentamac on 1/26/26.
//

import Foundation
struct WeatherResponse: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let relativeHumidity2M: Int
    let rain: Double
    let windSpeed10M: Double
    let weatherCode: Int
       let isDay: Int   // 1 = day, 0 = night

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case rain
        case windSpeed10M = "wind_speed_10m"
        case weatherCode = "weather_code"
                case isDay = "is_day"
    }
}

struct CurrentUnits: Codable {
    let time: String
    let interval: String
    let temperature2M: String
    let relativeHumidity2M: String
    let rain: String
    let windSpeed10M: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case rain
        case windSpeed10M = "wind_speed_10m"
    }
}
