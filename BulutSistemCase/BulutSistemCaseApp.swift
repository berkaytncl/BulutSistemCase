//
//  BulutSistemCaseApp.swift
//  BulutSistemCase
//
//  Created by Berkay Tuncel on 3.05.2024.
//

import SwiftUI

@main
struct BulutSistemCaseApp: App {
    
    init() {
        UINavigationBar.changeAppearance()
        UIToolbar.changeAppearance(clear: true)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
