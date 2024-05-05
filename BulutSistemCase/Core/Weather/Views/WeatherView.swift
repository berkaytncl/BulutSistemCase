//
//  WeatherView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showAddFavoriteView: Bool = false
    
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
        .sheet(isPresented: $showAddFavoriteView, content: {
            FavoriteView()
        })
        .fullScreenCover(item: $viewModel.selectedWeatherData, content: { selectedWeatherData in
            MapView(weatherDatas: viewModel.weatherDatas, selectedWeatherData: selectedWeatherData)
        })
    }
}

extension WeatherView {
    private func scrollViewMainContent(proxy: GeometryProxy) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            TabView {
                ForEach(viewModel.weatherDatas, id: \.id) { weatherData in
                    WeatherCell(weatherData: weatherData)
                        .onAppear {
                            viewModel.tempSelectedWeatherData = weatherData
                        }
                }
            }
            .frame(height: proxy.size.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .refreshable {
            viewModel.startUpdatingLocation()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddFavoriteView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
                .accentColor(.white)
            }

            ToolbarItem(placement: .bottomBar) {
                Button {
                    viewModel.selectWeatherData()
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
