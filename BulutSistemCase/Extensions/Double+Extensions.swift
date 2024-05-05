//
//  Double+Extensions.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation

extension Double {
    func convertKelvinToCelsius() -> Int {
        Int(self - 272.15)
    }
    
    func convertKelvinToFahrenheit() -> Int {
        Int((self * 9 / 5) - 457.87)
    }
}

