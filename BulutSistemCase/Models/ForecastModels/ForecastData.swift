//
//  ForecastData.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import Foundation

struct ForecastData: Codable, Equatable {
    let list: [Forecast]
    let city: City
    let country: String?
    
    static func == (lhs: ForecastData, rhs: ForecastData) -> Bool { lhs.list[0].id == rhs.list[0].id }
}
