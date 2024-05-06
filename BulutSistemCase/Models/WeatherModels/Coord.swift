//
//  Coord.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation

struct Coord: Codable, Equatable {
    let lat, lon: Double
    
    static func == (lhs: Coord, rhs: Coord) -> Bool { lhs.lat == rhs.lat && lhs.lon == rhs.lon }
}