//
//  Date+Extensions.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import SwiftUI

extension Date {
    static func getColorWithDayTime() -> [Color] {
        var colors: [Color] = []
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 8 || hour > 19 {
            colors.append(contentsOf: [Color.black.opacity(0.8), Color.black.opacity(0.5), Color.black.opacity(0.2)])
        } else {
            colors.append(contentsOf: [.blue, .cyan, .white])
        }
        return colors
    }
}
