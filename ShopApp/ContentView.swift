//
//  ContentView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Properties

    @AppStorage (StorageKey.isOnboardingShowed.rawValue) var isOnboardingShowed = false

    var body: some View {
        if isOnboardingShowed {
            MainView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
