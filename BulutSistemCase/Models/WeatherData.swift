//
//  WeatherData.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let conditions: WeatherCondition
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coord, weather, base
        case conditions = "main"
        case visibility, wind, clouds, dt, sys, timezone, id, name, cod
    }
}
