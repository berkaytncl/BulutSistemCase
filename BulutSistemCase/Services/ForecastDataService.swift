//
//  ForecastDataService.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import Foundation
import Combine

final class ForecastDataService {
    
    @Published private(set) var forecastDatas: [ForecastData] = []
    
    private let apiKey = "23ad6da6c56b202ecc38240b92e78d2c"
    private var cancellables = Set<AnyCancellable>()
    
    private func getForecastData(name: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(name)&appid=\(apiKey)") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: ForecastData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedForecastData in
                self?.forecastDatas.append(returnedForecastData)
            })
            .store(in: &cancellables)
    }
    
    func updateForecastDatas(names: [String]) {
        forecastDatas = []
        names.forEach { name in
            getForecastData(name: name)
        }
    }
}
