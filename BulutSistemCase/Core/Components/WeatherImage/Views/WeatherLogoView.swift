//
//  WeatherLogoView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI

struct WeatherLogoView: View {
    
    let weatherData: WeatherData
    let size: CGFloat
    
    init(weatherData: WeatherData, size: CGFloat = 100) {
        self.weatherData = weatherData
        self.size = size
    }
    
    var body: some View {
        VStack(spacing: 0) {
            WeatherImageView(icon: weatherData.weather[0].icon)
                .frame(width: size, height: size)
            Text(weatherData.weather[0].description.capitalized)
            HStack(spacing: 8) {
                Text("H:\(weatherData.conditions.tempMax.convertKelvinToCelsius())°")
                Text("L:\(weatherData.conditions.tempMin.convertKelvinToCelsius())°")
            }
        }
        .font(.system(size: 16, weight: .regular))
    }
}

#Preview {
    WeatherLogoView(weatherData: WeatherData.exampleWeatherData)
}
