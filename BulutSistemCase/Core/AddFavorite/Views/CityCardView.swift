//
//  CityCardView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 6.05.2024.
//

import SwiftUI

struct CityCardView: View {
    
    let weatherData: WeatherData
    let index: Int
    
    var body: some View {
        HStack {
            imageSection
            titleSection
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(20)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
    }
}

extension CityCardView {
    private var imageSection: some View {
        ZStack {
            WeatherLogoView(
                weather: weatherData.weather[0],
                conditions: weatherData.conditions,
                size: 50)
                .scaledToFill()
                .cornerRadius(10)
        }
        .padding(6)
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 4) {
            if index == 0 {
                Image(systemName: "location.fill")
            }
            Text(weatherData.name)
            Text("(\(weatherData.sys.country))")
        }
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    CityCardView(weatherData: WeatherData.exampleWeatherData, index: 0)
}
