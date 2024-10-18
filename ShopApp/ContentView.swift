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

    @StateObject private var router = AppRouter()

    var body: some View {
        if isOnboardingShowed {
            NavigationStack(path: $router.path) {
                router.build(.main)
                    .navigationDestination(for: AppRouter.Page.self) { page in
                        router.build(page)
                    }
                    .sheet(item: $router.sheet) { sheet in
                        router.build(sheet)
                            .presentationDetents([.fraction(0.3)])
                    }
            }
            .environmentObject(router)
        } else {
            ViewFactory.ondoarding.view
        }
    }
}

#Preview {
    ContentView()
}
