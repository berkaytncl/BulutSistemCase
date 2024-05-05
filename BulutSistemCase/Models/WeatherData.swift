//
//  WeatherData.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation

struct WeatherData: Codable, Equatable, Identifiable {
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
    
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool { lhs.id == rhs.id }
}

extension WeatherData {
    static let exampleWeatherData = WeatherData(coord: Coord(lat: 10.99, lon: 44.34), weather: [Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")], base: "stations", conditions: WeatherCondition(temp: 298.48, feelsLike: 298.74, tempMin: 297.56, tempMax: 300.05, pressure: 1015, humidity: 64), visibility: 10000, wind: Wind(speed: 0.62, deg: 349, gust: 1.18), clouds: Clouds(all: 100), dt: 1661870592, sys: Sys(country: "IT", sunrise: 1661834187, sunset: 1661882248), timezone: 7200, id: 3163858, name: "Zocca", cod: 200)
}
