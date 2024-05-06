//
//  CityInfo.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 6.05.2024.
//

import Foundation

struct CityInfo: Codable, Identifiable {
    let id: Int
    let country: String
    let name: String
}
