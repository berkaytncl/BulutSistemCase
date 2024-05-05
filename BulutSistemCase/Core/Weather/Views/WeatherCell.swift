//
//  WeatherCell.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI

struct WeatherCell: View {
        
    let weatherData: WeatherData
    
    var body: some View {
        VStack {
            weatherMainInformations
            Spacer()
        }
        .background(.clear)
    }
}

extension WeatherCell {
    private var weatherMainInformations: some View {
        VStack(spacing: 0) {
            Text("\(weatherData.name), \(weatherData.sys.country)")
                .font(.system(size: 40, weight: .light))
            HStack {
                Text("°")
                    .opacity(0)
                Text("\(weatherData.conditions.temp.convertKelvinToCelsius())°")
            }
            .font(.system(size: 70, weight: .light))
            
            WeatherLogoView(weatherData: weatherData)
        }
        .foregroundColor(.white)
        .padding(40)
    }
}

#Preview {
    NavigationView {
        WeatherCell(weatherData: WeatherData.exampleWeatherData)
    }
}
