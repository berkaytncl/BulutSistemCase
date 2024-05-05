//
//  UIToolbar+Extensions.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 5.05.2024.
//

import SwiftUI

extension UIToolbar {
    static func changeAppearance(clear: Bool) {
        let appearance = UIToolbarAppearance()
        
        if clear {
            appearance.configureWithOpaqueBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }

        appearance.shadowColor = .clear
        appearance.backgroundColor = .clear
        
        UIToolbar.appearance().standardAppearance = appearance
        UIToolbar.appearance().compactAppearance = appearance
        UIToolbar.appearance().scrollEdgeAppearance = appearance
    }
}
