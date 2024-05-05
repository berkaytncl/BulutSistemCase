//
//  RootView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: Date.getColorWithDayTime(),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                WeatherView()
            }
        }
    }
}

#Preview {
    RootView()
}
