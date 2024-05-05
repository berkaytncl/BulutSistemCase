//
//  WeatherImageViewModel.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI
import Combine

@MainActor
final class WeatherImageViewModel: ObservableObject {
    
    @Published private(set) var image: UIImage? = nil
    @Published private(set) var isLoading: Bool = false
    
    private let icon: String
    private let dataService: WeatherImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(icon: String) {
        self.icon = icon
        dataService = WeatherImageService(icon: icon)
        addSubscribers()
        isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
