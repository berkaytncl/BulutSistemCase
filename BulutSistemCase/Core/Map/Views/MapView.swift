//
//  MapView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel: MapViewModel
    
    init(weatherDatas: [WeatherData], selectedWeatherData: WeatherData) {
        _viewModel = StateObject(wrappedValue: MapViewModel(weatherDatas: weatherDatas, selectedWeatherData: selectedWeatherData))
    }
    
    var body: some View {
        ZStack {
            mapLayer.ignoresSafeArea()
                        
            VStack {
                HStack {
                    doneButton
                    Spacer()
                }
                Spacer()
                locationsPreviewStack
            }
            .padding(20)
        }
        .onAppear {
            debugPrint(viewModel.weatherDatas)
        }
    }
}

extension MapView {
    private var doneButton: some View {
        Button {
            NotificationCenter.default.post(name: .closeMapViewNotification, object: nil)
        } label: {
            Text("Done")
                .font(.headline)
        }
        .buttonStyle(BorderedProminentButtonStyle())
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.weatherDatas,
            annotationContent: { weatherData in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: weatherData.coord.lat, longitude: weatherData.coord.lon)) {
                LocationMapAnnotationView()
                    .scaleEffect(viewModel.selectedLocationData == weatherData ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.changeMapLocation(weatherData: weatherData)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(viewModel.weatherDatas) { weatherData in
                if viewModel.selectedLocationData == weatherData {
                    LocationPreviewView()
                        .environmentObject(viewModel)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}

#Preview {
    MapView(weatherDatas: [WeatherData.exampleWeatherData], selectedWeatherData: WeatherData.exampleWeatherData)
}
