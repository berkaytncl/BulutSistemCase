//
//  LocationMapAnnotationView.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 4.05.2024.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "cloud.sun.bolt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(.accent)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accent)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    LocationMapAnnotationView()
}
