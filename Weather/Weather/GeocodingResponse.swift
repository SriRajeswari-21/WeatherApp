//
//  GeocodingResponse.swift
//  Weather
//
//  Created by rentamac on 1/30/26.
//

import Foundation
import Foundation

struct GeocodingResponse: Decodable {
    let results: [GeocodingResult]?
}

struct GeocodingResult: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String?
}
