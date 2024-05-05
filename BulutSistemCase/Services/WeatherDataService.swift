//
//  WeatherDataService.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation
import Combine

final class WeatherDataService {
    
    @Published private(set) var currentLocationWeatherData: WeatherData? = nil
    @Published private(set) var favoritedWeatherDatas: [WeatherData] = []
    
    private let apiKey = "23ad6da6c56b202ecc38240b92e78d2c"
    private let favoriteLocationsManager = FavoriteLocationsDataManager.instance
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getFavoriteWeatherDatas()
    }
    
    private func getWeatherData(coord: Coord) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coord.lat)&lon=\(coord.lon)&appid=\(apiKey)") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedWeatherData in
                guard let self else { return }
                self.currentLocationWeatherData = returnedWeatherData
            })
            .store(in: &cancellables)
    }
    
    private func getWeatherData(name: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(apiKey)") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedWeatherData in
                guard let self else { return }
                self.favoritedWeatherDatas.append(returnedWeatherData)
            })
            .store(in: &cancellables)
    }
    
    private func getCurrentLocationWeatherData(coord: Coord) {
        currentLocationWeatherData = nil
        getWeatherData(coord: coord)
    }
    
    private func getFavoriteWeatherDatas() {
        favoritedWeatherDatas = []
        favoriteLocationsManager.savedEntities.forEach { entity in
            if let name = entity.name {
                getWeatherData(name: name)
            }
        }
    }
}

extension WeatherDataService {
    func updateLocation(coord: Coord) {
        getCurrentLocationWeatherData(coord: coord)
    }
    
    func addNewFavoriteLocation(_ name: String) {
        favoriteLocationsManager.addNewFavoriteLocation(name)
    }
    
    func removeFavoriteLocation(_ name: String) {
        favoriteLocationsManager.removeFavoriteLocation(name)
    }
}
