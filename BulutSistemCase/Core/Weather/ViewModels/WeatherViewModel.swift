//
//  WeatherViewModel.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published private(set) var weatherDatas: [WeatherData] = []
    @Published var selectedWeatherData: WeatherData?
    @Published var tempSelectedWeatherData: WeatherData?
    
    @Published private(set) var coord: Coord?
    
    private let weatherDataService = WeatherDataService()
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        weatherDataService.$currentLocationWeatherData
            .combineLatest(weatherDataService.$favoritedWeatherDatas)
            .map(mapAllWeatherData)
            .sink { [weak self] returnedWeatherDatas in
                self?.weatherDatas = returnedWeatherDatas
            }
            .store(in: &cancellables)
        
        locationManager.$lastKnownLocation
            .sink { [weak self] coord in
                guard let self else { return }
                self.coord = coord
                self.updateLocation()
            }
            .store(in: &cancellables)
    }
    
    private func mapAllWeatherData(weatherData: WeatherData?, favoritedWeatherDatas: [WeatherData]) -> [WeatherData] {
        var weatherDatas = favoritedWeatherDatas
        if let weatherData = weatherData {
            weatherDatas.insert(weatherData, at: 0)
        }
        return weatherDatas
    }
    
    func selectWeatherData() {
        selectedWeatherData = tempSelectedWeatherData
    }
    
    func deselectWeatherData() {
        selectedWeatherData = nil
    }
}

// MARK: WeatherDataService

extension WeatherViewModel {
    func updateLocation() {
        guard let coord else { return }
        weatherDataService.updateLocation(coord: coord)
    }
}

// MARK: LocationManager

extension WeatherViewModel {
    func checkLocationAuthorization() {
        locationManager.checkLocationAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}
