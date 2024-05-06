//
//  CitiesDataService.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import Foundation

final class CitiesDataService {
    
    @Published private(set) var citiesData: [CityInfo] = []
    
    func loadData() async {
        guard let url = Bundle.main.url(forResource: "current.city.list", withExtension: "json") else { return }
        
        if let data = try? Data(contentsOf: url),
           let citiesData = try? JSONDecoder().decode([CityInfo].self, from: data) {
            await MainActor.run { [weak self] in
                self?.citiesData = citiesData
            }
        }
    }
}
