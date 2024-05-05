//
//  WeatherImageView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI

struct WeatherImageView: View {
    
    @StateObject var viewModel: WeatherImageViewModel
    
    init(icon: String) {
        _viewModel = StateObject(wrappedValue: WeatherImageViewModel(icon: icon))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

#Preview {
    WeatherImageView(icon: WeatherData.exampleWeatherData.weather[0].icon)
        .padding()
        .previewLayout(.sizeThatFits)
}
