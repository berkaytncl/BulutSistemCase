//
//  WeatherCell.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI

struct WeatherCell: View {
    
    let weatherData: WeatherData
    let forecastData: ForecastData?
    let proxy: GeometryProxy
    
    init(weatherData: WeatherData, forecastData: ForecastData?, proxy: GeometryProxy) {
        self.weatherData = weatherData
        self.forecastData = forecastData
        self.proxy = proxy
    }
    
    var body: some View {
        VStack(spacing: 0) {
            weatherMainInformations
            
            forecastInformations
            
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
            
            WeatherLogoView(weather: weatherData.weather[0], conditions: weatherData.conditions)
        }
        .foregroundColor(.white)
        .padding(40)
    }
    
    private var forecastInformations: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                if let forecastData {
                    ForEach(forecastData.list, id: \.id) { item in
                        VStack(spacing: 0) {
                            Text(getConvertedDate(dtTxt: item.dtTxt))
                            
                            WeatherLogoView(weather: item.weather[0], conditions: item.conditions, size: 50)
                        }
                        .font(.system(size: 16, weight: .regular))
                    }
                }
            }
        }
        .frame(height: 125)
        .padding(.horizontal, 8)
        .frame(width: proxy.size.width - 50)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        )
        .padding(.horizontal)
    }
    
    private func getConvertedDate(dtTxt: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let inputDate = dateFormatter.date(from: dtTxt) {
            dateFormatter.dateFormat = "HH"
            return dateFormatter.string(from: inputDate)
        }
        return ""
    }
}
