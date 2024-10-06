//
//  MainViewModel.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

extension MainView {
    @MainActor
    final class ViewModel: ObservableObject {

        // MARK: - Properties

        @Published var folderName: String = ""
        

        // MARK: - Instance methods
    }
}
