//
//  WeatherView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var selectedTab = 0
    
    let pub = NotificationCenter.default
        .publisher(for: .closeMapViewNotification)
    
    var body: some View {
        GeometryReader { proxy in
            scrollViewMainContent(proxy: proxy)
        }
        .onAppear(perform: viewModel.checkLocationAuthorization)
        .onReceive(pub) { _ in
            viewModel.deselectWeatherData()
        }
        .fullScreenCover(item: $viewModel.selectedWeatherData, content: { selectedWeatherData in
            MapView(weatherDatas: viewModel.weatherDatas, selectedWeatherData: selectedWeatherData)
        })
    }
}

extension WeatherView {
    private func scrollViewMainContent(proxy: GeometryProxy) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            TabView(selection: $selectedTab) {
                ForEach(Array(viewModel.weatherDatas.enumerated()), id: \.element) { index, weatherData in
                    WeatherCell(
                        weatherData: weatherData,
                        forecastData: viewModel.matchedForecastData(weatherData: weatherData),
                        proxy: proxy)
                    .tag(index)
                }
            }
            .frame(height: proxy.size.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .refreshable {
            if selectedTab == 0 {
                viewModel.startUpdatingLocation()
            } else {
                viewModel.updateData(at: selectedTab)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    FavoriteView()
                        .environmentObject(viewModel)
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
                .accentColor(.white)
            }

            ToolbarItem(placement: .bottomBar) {
                Button {
                    if selectedTab < viewModel.weatherDatas.count {
                        viewModel.selectWeatherData(weatherData: viewModel.weatherDatas[selectedTab])
                    }
                } label: {
                    Text("Show on Map")
                        .font(.headline)
                        .frame(width: 125, height: 35)
                }
                .buttonStyle(.bordered)
            }
        })
    }
}

#Preview {
    NavigationView {
        WeatherView()
    }
}
