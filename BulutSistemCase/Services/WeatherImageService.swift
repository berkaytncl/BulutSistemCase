//
//  WeatherImageService.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI
import Combine

final class WeatherImageService {
    
    @Published private(set) var image: UIImage? = nil
    
    private let icon: String
    private var imageSubscription: AnyCancellable?
    
    init(icon: String) {
        self.icon = icon
        downloadWeatherImage()
    }
    
    private func downloadWeatherImage() {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
            })
    }
}
