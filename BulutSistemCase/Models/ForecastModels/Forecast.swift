//
//  Forecast.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import Foundation

struct Forecast: Codable, Identifiable {
    let id = UUID().uuidString
    let conditions: WeatherCondition
    let weather: [Weather]
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case conditions = "main"
        case weather
        case dtTxt = "dt_txt"
    }
}
