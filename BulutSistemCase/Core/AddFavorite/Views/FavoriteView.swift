//
//  FavoriteView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    
    var body: some View {
        VStack {
            if favoriteViewModel.showFilteredCities {
                searchedCities
            } else {
                favoritedWeathers
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("Weather")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $favoriteViewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search city name...")
        )
        .task {
            await favoriteViewModel.getCitiesData()
        }
    }
}

extension FavoriteView {
    private var searchedCities: some View {
        List {
            ForEach(favoriteViewModel.filteredCities) { city in
                HStack {
                    Text(city.name)
                    Text("(\(city.country))")
                    Spacer()
                }
                .background(Color.gray.opacity(0.0001))
                .onTapGesture {
                    hideKeyboard()
                    if weatherViewModel.weatherDatasIsContain(name: city.name) {
                        favoriteViewModel.addNewFavoriteCity(name: city.name)
                        weatherViewModel.updatedFavoriteDatas()
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .padding(.vertical)
    }
    
    private var favoritedWeathers: some View {
        List {
            ForEach(Array(weatherViewModel.weatherDatas.enumerated()), id: \.element) { index, weatherData in
                CityCardView(weatherData: weatherData, index: index)
                    .deleteDisabled(index == 0)
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    favoriteViewModel.deleteFavoriteCity(name: weatherViewModel.weatherDatas[index].name)
                    weatherViewModel.updatedFavoriteDatas()
                }
            })
        }
        .listStyle(PlainListStyle())
        .padding(.bottom)
        .clipped()
    }
}

extension FavoriteView {
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    NavigationView {
        FavoriteView()
            .environmentObject(WeatherViewModel())
    }
}
