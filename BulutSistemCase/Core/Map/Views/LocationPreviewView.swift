//
//  LocationPreviewView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var viewModel: MapViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            imageSection
            
            Spacer()
            
            VStack {
                titleSection
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            WeatherLogoView(
                weather: viewModel.selectedLocationData.weather[0],
                conditions: viewModel.selectedLocationData.conditions)
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
            Text(viewModel.selectedLocationData.name)
            
            Text("(\(viewModel.selectedLocationData.sys.country))")
        }
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var nextButton: some View {
        Button(action: viewModel.nextButtonPressed) {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    LocationPreviewView()
        .environmentObject(MapViewModel(weatherDatas: [WeatherData.exampleWeatherData], selectedWeatherData: WeatherData.exampleWeatherData))
}
