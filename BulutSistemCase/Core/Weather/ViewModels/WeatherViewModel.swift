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
    
    @Published private var forecastDatas: [ForecastData] = []
    
    private let weatherDataService = WeatherDataService()
    private let forecastDataService = ForecastDataService()
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
                guard let self else { return }
                self.weatherDatas = returnedWeatherDatas
                self.weatherDatasUpdated()
            }
            .store(in: &cancellables)
        
        locationManager.$lastKnownLocation
            .sink { [weak self] coord in
                guard let self else { return }
                self.updateLocation(coord: coord)
            }
            .store(in: &cancellables)
        
        forecastDataService.$forecastDatas
            .sink { [weak self] forecastDatas in
                self?.forecastDatas = forecastDatas
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
    
    private func mapWeatherDataToForecastData(weatherData: WeatherData?) -> ForecastData? {
        guard let weatherData else { return nil }
        return forecastDatas.first { $0.city.name == weatherData.name }
    }
    
    private func weatherDatasUpdated() {
        forecastDataService.updateForecastDatas(names: weatherDatas.map { $0.name })
    }
    
    func matchedForecastData(weatherData: WeatherData) -> ForecastData? {
        mapWeatherDataToForecastData(weatherData: weatherData)
    }
    
    func selectWeatherData(weatherData: WeatherData) {
        selectedWeatherData = weatherData
    }
    
    func deselectWeatherData() {
        selectedWeatherData = nil
    }
    
    func weatherDatasIsContain(name: String) -> Bool {
        weatherDatas
            .map { $0.name }
            .filter { $0 == name }
            .isEmpty
    }
}

// MARK: WeatherDataService

extension WeatherViewModel {
    func updateLocation(coord: Coord?) {
        guard let coord else { return }
        weatherDataService.updateLocation(coord: coord)
    }
    
    func updateData(at index: Int) {
        weatherDataService.updateData(at: index)
    }
    
    func updatedFavoriteDatas() {
        weatherDataService.updatedFavoriteDatas()
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
