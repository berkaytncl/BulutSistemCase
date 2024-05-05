//
//  MapViewModel.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI
import MapKit

@MainActor
final class MapViewModel: ObservableObject {
    
    @Published private(set) var weatherDatas: [WeatherData] = []
    @Published private(set) var selectedLocationData: WeatherData {
        didSet {
            selectedLocationCoordinate = CLLocationCoordinate2D(
                latitude: selectedLocationData.coord.lat,
                longitude: selectedLocationData.coord.lon)
            
            updateCameraPosition(weatherData: selectedLocationData)
        }
    }
    @Published private(set) var selectedLocationCoordinate: CLLocationCoordinate2D
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(weatherDatas: [WeatherData], selectedWeatherData: WeatherData) {
        self.weatherDatas = weatherDatas
        self.selectedLocationData = selectedWeatherData
        
        selectedLocationCoordinate = CLLocationCoordinate2D(
            latitude: selectedWeatherData.coord.lat,
            longitude: selectedWeatherData.coord.lon)
        
        changeMapLocation(weatherData: selectedWeatherData)
    }
    
    private func updateCameraPosition(weatherData: WeatherData) {
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(
                center: selectedLocationCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        }
    }
    
    func changeMapLocation(weatherData: WeatherData) {
        withAnimation(.easeInOut) {
            selectedLocationData = weatherData
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = weatherDatas.firstIndex(of: selectedLocationData) else { return }
        let nextIndex = (currentIndex + 1) % weatherDatas.count
        changeMapLocation(weatherData: weatherDatas[nextIndex])
    }
}
