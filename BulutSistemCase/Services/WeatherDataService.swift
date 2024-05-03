//
//  WeatherDataService.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation
import Combine

final class WeatherDataService {
    
    @Published var weatherData: WeatherData? = nil
    
    var weatherDataSubscription: AnyCancellable?
    
    init(coord: Coord) {
        getWeatherData(coord: coord)
    }
    
    func getWeatherData(coord: Coord) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coord.lat)&lon=\(coord.lon)&appid=23ad6da6c56b202ecc38240b92e78d2c") else { return }
         
        weatherDataSubscription = NetworkingManager.download(url: url)
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedWeatherData in
                guard let self else { return }
                self.weatherData = returnedWeatherData
                self.weatherDataSubscription?.cancel()
            })
    }
}
