//
//  ShopAppApp.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

@main
struct ShopAppApp: App {

    // MARK: - Properties

    @State private var isShowContentView = false

    var body: some Scene {
        WindowGroup {
            if isShowContentView {
                ContentView()
            } else {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isShowContentView.toggle()
                        }
                    }
            }
        }
    }
}
