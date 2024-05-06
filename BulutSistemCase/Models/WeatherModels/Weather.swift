//
//  Weather.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
