//
//  WeatherLogoView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI

struct WeatherLogoView: View {
    
    let weather: Weather
    let conditions: WeatherCondition
    let size: CGFloat
    
    init(weather: Weather, conditions: WeatherCondition, size: CGFloat = 100) {
        self.weather = weather
        self.conditions = conditions
        self.size = size
    }
    
    var body: some View {
        VStack(spacing: 0) {
            WeatherImageView(icon: weather.icon)
                .frame(width: size, height: size)
            Text(weather.description.capitalized)
            HStack(spacing: 8) {
                Text("H:\(conditions.tempMax.convertKelvinToCelsius())°")
                Text("L:\(conditions.tempMin.convertKelvinToCelsius())°")
            }
        }
        .font(.system(size: 16, weight: .regular))
    }
}

#Preview {
    let example = WeatherData.exampleWeatherData
    return WeatherLogoView(weather: example.weather[0], conditions: example.conditions)
}
