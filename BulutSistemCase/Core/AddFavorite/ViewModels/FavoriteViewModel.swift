//
//  FavoriteViewModel.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import Foundation
import Combine

@MainActor
final class FavoriteViewModel: ObservableObject {

    @Published private(set) var cities: [CityInfo] = []
    @Published private(set) var filteredCities: [CityInfo] = []
    
    @Published var searchText: String = ""
    
    private let citiesDataService = CitiesDataService()
    private let favoriteLocationsManager = FavoriteLocationsDataManager.instance
    
    private var cancellables = Set<AnyCancellable>()
    
    var showFilteredCities: Bool {
        searchText.count > 1
    }
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        citiesDataService.$citiesData
            .sink { [weak self] returnedCitiesData in
                self?.cities = returnedCitiesData
            }
            .store(in: &cancellables)
        
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterCities(searchText: searchText)
            }
            .store(in: &cancellables)
    }

    private func filterCities(searchText: String) {
        guard !searchText.isEmpty else {
            filteredCities = cities
            return
        }
        
        let searchText = searchText.lowercased()
        filteredCities = cities.filter { $0.name.lowercased().contains(searchText) }
    }
    
    func getCitiesData() async {
        await citiesDataService.loadData()
    }
    
    func addNewFavoriteCity(name: String) {
        favoriteLocationsManager.addNewFavoriteLocation(name)
        searchText = ""
    }
    
    func deleteFavoriteCity(name: String) {
        favoriteLocationsManager.removeFavoriteLocation(name)
    }
}
