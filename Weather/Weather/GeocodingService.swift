//
//  GeocodingService.swift
//  Weather
//
//  Created by rentamac on 1/30/26.
//

import Foundation
import Foundation

protocol GeocodingServiceProtocol {
    func fetchCoordinates(for city: String) async throws -> GeocodingResult
}

final class GeocodingService: GeocodingServiceProtocol {

    func fetchCoordinates(for city: String) async throws -> GeocodingResult {

        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString =
        "https://geocoding-api.open-meteo.com/v1/search?name=\(cityEncoded)&count=1"

        let url = URL(string: urlString)!

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(GeocodingResponse.self, from: data)

        guard let result = response.results?.first else {
            throw URLError(.badServerResponse)
        }

        return result
    }
}
